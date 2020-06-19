Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C32002AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgFSHY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 03:24:28 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:32835
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbgFSHY1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 03:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixQbll3G1s4dFtvdNSC3VXWMNMbfN/ZADYYbf4gRyomByOiFyUTOKHAGhWQdH8MrxM70o0Ogz5A7sUOma+rSz38kkkItURD0xufZpN5bC0K93Gys0kRCgWyHOwDl6YMf4PW2eZFegM2JFCNZzl941gCLhbCv9M4gbMMCQyNLeeyXoOfp+PSDgAHgx/pPvW8eVLMhE+k5GwRTQodvTJnH9Gx7YbboklmpHZ71NdhVsP234lvgLvyc8NMHPQGfFty9QLewpwUojam8yzjU1LIV5lSDqyb3DmVifA5ETGxqqaujcUgVUcAqgr9rzKwGpQWnb5+0BG3G1ji08NlxyVlP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApBG1sJ+ZKWgKHHsFeFTPy2FCE0nKFWscP2B49FzwPo=;
 b=C04tcdRE6pog0mk/4JMkB3JumGDYNEGMuK42PaIi0SrxhzvWfbxa2xHNgzJ1nl/vCT/iB7e85xoIQoQvLjAZR3aicO1NzTcPzVf7gapVYqzcBtYKXkSL8WFhueMQ1HddIYlR14has9vAufsxF8K2LPgMGOHP5qGEn7FZs5xQTjIoJ0z0SXbOWq4N+aHpUZxdkx95UtsUqydyiPy2I669RWMRhRosDR57RJQKep/BZJ07NYbs/nhZSRQ1oR7DubR1Ap+KUhybPMB5RAi44YFhh/8G4C0IKUc04soU4QXE8wUtKaH+dbkoEnKmoeKOBmQjkZk/l+IycMZX7FPmMOvKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApBG1sJ+ZKWgKHHsFeFTPy2FCE0nKFWscP2B49FzwPo=;
 b=mIamYsLL3m2ztrgq8BYHtgRP0r7sN3GkkVavnqOE+ko7bKNiVXWWg7hWRSN0nwrHHfeaI2Qco3cMjipoP62jN+awg4F4rVBEYh86XtExs0yc0k3fgFq48AI/RlWlyoRd8paZPsh5w3jRb/Yu9vmmQ5dVJn9yhCPOqpa8PW1vdgau+wxRKq7+D4JjGNSf3vHWgI3jwpkp198QY2C33ZVwozGTYIqdHlVXBuZMVh+wCquOBBWcqJAb4j9JIgq6psD+ooo7xMi/x5FHfjpwKUIEQ2lPUyoNjcstX9+ecUSPQe9fgSP/7r6C+bBDpFG0Y3eePKFGmTcLJORodJwz0nfKxw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Fri, 19 Jun
 2020 07:24:21 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 07:24:21 +0000
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <ec07af82-dd74-7fb3-eb42-dc30b54f90bb@suse.com>
Date:   Fri, 19 Jun 2020 15:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619015946.65638-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4ZyWuUajz9QaWOpDoT9wWz6L3igjW2mCF"
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0065.namprd06.prod.outlook.com (2603:10b6:a03:14b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 07:24:20 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef1f46a-46a2-47de-69a5-08d81421c902
X-MS-TrafficTypeDiagnostic: AM0PR04MB6787:
X-Microsoft-Antispam-PRVS: <AM0PR04MB67877396CF177805F04F80DAD6980@AM0PR04MB6787.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otwWDh3I4dCP2Sm/Ddd2KZsc9c2WyywVx2kdM92s2dht64ff4e6xlyS3DIgbcO/wjcbFh+tWKoBUOQZBwXYUDm3SyOTDLO22uFSqb0jUk/VbyQC6/WZbw0Odxn+7r6F/Y25YrNfDV38ND8GGEOqoFG/YTF56Nm3yab+6Q4ZgTjva0CGxj4dkAERQws4WWIGHRwiWGt026kYdqPygRAt1qf58/0eSuyp4lb6CRUw703t2vVr/0KhAQKeXb71q4PxraNcf69efq+g3sMfVkSbKJvTmo8j7RQpJMrMX5Ajmiyn7p6nIj5lCIxPIbNIcKevjiX9NqjYiTwF0PnKmgnCi93XYftdi4k5SBN0DFtmL21THBRlvc8oNtr6wXpZRlp3BUPfiMk9MUXHVmXW+eHqSkC9Ob+/fsYKh/8ncZtI9hbJL8jeWP6i8Ov8d5oosKzeIJYUBqyEv+mq6rZsApAXntw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(26005)(36756003)(235185007)(6666004)(83380400001)(86362001)(66946007)(33964004)(956004)(52116002)(186003)(16526019)(31686004)(2616005)(31696002)(30864003)(6916009)(16576012)(6706004)(8676002)(8936002)(478600001)(2906002)(66476007)(21480400003)(66556008)(5660300002)(316002)(6486002)(78286006)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kPJHjZB+qdqoB2kdDgHTTt0HI9i56aYdyUUN6hrmvDNEcfE83dA1PYqerMd0LUeVFhgPTvu33t19fPb2Q+NJtSFFPFrbx/MscmSzBOnizCx3+DfpouKFWbWcBbi6Dh+gsMh2eoMZyTPffygJya5SH1EFdHX+sgMvT1x7gh0zSWVbx1gybkNySTKzvXOdrM4JM4sntfL7+HnHdm6t4gt5sA9pdgFtMBUEqnjgiQSXHHs72rjsSH52ED/Att7em52Pa5eVbUOoRxDfN7lXhHO3KFvWWrFeJf6zMMe/9kqNwrFk1EESPzF172d4TExI+tZCEqWAGg01a1prl5ELs8Elram2BZ/F4YNRVbghW6w+Or7qks53yvlcxEB+yBYDpLDJt7Q3CSsQE8BYWkRHef9bvT2GTfANWHxvJmUy7l4M4xPTNrodjz3Q5umMFvAMue6UduQrzLTx4qASXw5mp1lW3MsKNBmSX6CPgX58myQeHu8=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef1f46a-46a2-47de-69a5-08d81421c902
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 07:24:21.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYAyKv32wdqS1LO0derip1dRxvFHpt6gZ019g64DQDF/sLtLjR4ym/vaY6BkPrlB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--4ZyWuUajz9QaWOpDoT9wWz6L3igjW2mCF
Content-Type: multipart/mixed; boundary="C9YmGwwzj1UvvOoXRiTFfxJHVQaIiqQYr"

--C9YmGwwzj1UvvOoXRiTFfxJHVQaIiqQYr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/19 =E4=B8=8A=E5=8D=889:59, Qu Wenruo wrote:
> This patch will add the following sysfs interface:
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rfer
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/excl
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_rfer
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_excl
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/lim_flags
>  ^^^ Above are already in "btrfs qgroup show" command output ^^^
>=20
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc
>=20
> The last 3 rsv related members are not visible to users, but can be ver=
y
> useful to debug qgroup limit related bugs.
>=20
> Also, to avoid '/' used in <qgroup_id>, the seperator between qgroup
> level and qgroup id is changed to '_'.
>=20
> The interface is not hidden behind 'debug' as I want this interface to
> be included into production build so we could have an easier life to
> debug qgroup rsv related bugs.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h  |   1 +
>  fs/btrfs/qgroup.c |  38 ++++++++----
>  fs/btrfs/qgroup.h |  12 ++++
>  fs/btrfs/sysfs.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++++=

>  fs/btrfs/sysfs.h  |   6 ++
>  5 files changed, 194 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d8301bf240e0..7576dfe39841 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -779,6 +779,7 @@ struct btrfs_fs_info {
>  	u32 thread_pool_size;
> =20
>  	struct kobject *space_info_kobj;
> +	struct kobject *qgroup_kobj;
> =20
>  	u64 total_pinned;
> =20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 74eb98479109..04fdd42f0eb5 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -22,6 +22,7 @@
>  #include "extent_io.h"
>  #include "qgroup.h"
>  #include "block-group.h"
> +#include "sysfs.h"
> =20
>  /* TODO XXX FIXME
>   *  - subvol delete -> delete when ref goes to 0? delete limits also?
> @@ -192,38 +193,47 @@ static struct btrfs_qgroup *add_qgroup_rb(struct =
btrfs_fs_info *fs_info,
>  	struct rb_node **p =3D &fs_info->qgroup_tree.rb_node;
>  	struct rb_node *parent =3D NULL;
>  	struct btrfs_qgroup *qgroup;
> +	int ret;
> =20
>  	while (*p) {
>  		parent =3D *p;
>  		qgroup =3D rb_entry(parent, struct btrfs_qgroup, node);
> =20
> -		if (qgroup->qgroupid < qgroupid)
> +		if (qgroup->qgroupid < qgroupid) {
>  			p =3D &(*p)->rb_left;
> -		else if (qgroup->qgroupid > qgroupid)
> +		} else if (qgroup->qgroupid > qgroupid) {
>  			p =3D &(*p)->rb_right;
> -		else
> +		} else {
>  			return qgroup;
> +		}

Oh, extra brackets forgot to remove during debug.

Will address them in next update.

Thanks,
Qu

>  	}
> =20
>  	qgroup =3D kzalloc(sizeof(*qgroup), GFP_ATOMIC);
>  	if (!qgroup)
>  		return ERR_PTR(-ENOMEM);
> -
>  	qgroup->qgroupid =3D qgroupid;
>  	INIT_LIST_HEAD(&qgroup->groups);
>  	INIT_LIST_HEAD(&qgroup->members);
>  	INIT_LIST_HEAD(&qgroup->dirty);
> =20
> +	ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> +	if (ret < 0) {
> +		kfree(qgroup);
> +		return ERR_PTR(ret);
> +	}
> +
>  	rb_link_node(&qgroup->node, parent, p);
>  	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
> =20
>  	return qgroup;
>  }
> =20
> -static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
> +static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
> +			    struct btrfs_qgroup *qgroup)
>  {
>  	struct btrfs_qgroup_list *list;
> =20
> +	btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
>  	list_del(&qgroup->dirty);
>  	while (!list_empty(&qgroup->groups)) {
>  		list =3D list_first_entry(&qgroup->groups,
> @@ -252,7 +262,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_i=
nfo, u64 qgroupid)
>  		return -ENOENT;
> =20
>  	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
> -	__del_qgroup_rb(qgroup);
> +	__del_qgroup_rb(fs_info, qgroup);
>  	return 0;
>  }
> =20
> @@ -351,6 +361,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *=
fs_info)
>  		goto out;
>  	}
> =20
> +	ret =3D btrfs_sysfs_add_qgroups(fs_info);
> +	if (ret < 0)
> +		goto out;
>  	/* default this to quota off, in case no status key is found */
>  	fs_info->qgroup_flags =3D 0;
> =20
> @@ -500,16 +513,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info=
 *fs_info)
>  		ulist_free(fs_info->qgroup_ulist);
>  		fs_info->qgroup_ulist =3D NULL;
>  		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		btrfs_sysfs_del_qgroups(fs_info);
>  	}
> =20
>  	return ret < 0 ? ret : 0;
>  }
> =20
> -static u64 btrfs_qgroup_subvolid(u64 qgroupid)
> -{
> -	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
> -}
> -
>  /*
>   * Called in close_ctree() when quota is still enabled.  This verifies=
 we don't
>   * leak some reserved space.
> @@ -562,7 +571,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info =
*fs_info)
>  	while ((n =3D rb_first(&fs_info->qgroup_tree))) {
>  		qgroup =3D rb_entry(n, struct btrfs_qgroup, node);
>  		rb_erase(n, &fs_info->qgroup_tree);
> -		__del_qgroup_rb(qgroup);
> +		__del_qgroup_rb(fs_info, qgroup);
>  	}
>  	/*
>  	 * We call btrfs_free_qgroup_config() when unmounting
> @@ -571,6 +580,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info =
*fs_info)
>  	 */
>  	ulist_free(fs_info->qgroup_ulist);
>  	fs_info->qgroup_ulist =3D NULL;
> +	btrfs_sysfs_del_qgroups(fs_info);
>  }
> =20
>  static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, =
u64 src,
> @@ -943,6 +953,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_inf=
o)
>  		goto out;
>  	}
> =20
> +	ret =3D btrfs_sysfs_add_qgroups(fs_info);
> +	if (ret < 0)
> +		goto out;
>  	/*
>  	 * 1 for quota root item
>  	 * 1 for BTRFS_QGROUP_STATUS item
> @@ -1089,6 +1102,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo)
>  		fs_info->qgroup_ulist =3D NULL;
>  		if (trans)
>  			btrfs_end_transaction(trans);
> +		btrfs_sysfs_del_qgroups(fs_info);
>  	}
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	return ret;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 3be5198a3719..728ffea7de48 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/spinlock.h>
>  #include <linux/rbtree.h>
> +#include <linux/kobject.h>
>  #include "ulist.h"
>  #include "delayed-ref.h"
> =20
> @@ -223,8 +224,19 @@ struct btrfs_qgroup {
>  	 */
>  	u64 old_refcnt;
>  	u64 new_refcnt;
> +
> +	/*
> +	 * Sysfs kobjectid
> +	 */
> +	struct kobject kobj;
> +	struct completion kobj_unregister;
>  };
> =20
> +static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
> +{
> +	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
> +}
> +
>  /*
>   * For qgroup event trace points only
>   */
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index a39bff64ff24..8468c0a22695 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -19,6 +19,7 @@
>  #include "volumes.h"
>  #include "space-info.h"
>  #include "block-group.h"
> +#include "qgroup.h"
> =20
>  struct btrfs_feature_attr {
>  	struct kobj_attribute kobj_attr;
> @@ -1455,6 +1456,154 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_inf=
o *fs_info)
>  	return error;
>  }
> =20
> +#define QGROUP_ATTR(_member)						\
> +static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj=
,	\
> +				      struct kobj_attribute *a, char *buf) \
> +{									\
> +	struct kobject *fsid_kobj =3D qgroup_kobj->parent->parent;	\
> +	struct btrfs_fs_info *fs_info =3D to_fs_info(fsid_kobj);		\
> +	struct btrfs_qgroup *qgroup =3D container_of(qgroup_kobj,		\
> +			struct btrfs_qgroup, kobj);			\
> +	u64 val;							\
> +									\
> +	spin_lock(&fs_info->qgroup_lock);				\
> +	val =3D qgroup->_member;						\
> +	spin_unlock(&fs_info->qgroup_lock);				\
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
> +}									\
> +BTRFS_ATTR(qgroup, _member, btrfs_qgroup_show_##_member)
> +
> +#define QGROUP_RSV_ATTR(_name, _type)					\
> +static ssize_t btrfs_qgroup_rsv_show_##_name(struct kobject *qgroup_ko=
bj,\
> +				      struct kobj_attribute *a, char *buf) \
> +{									\
> +	struct kobject *fsid_kobj =3D qgroup_kobj->parent->parent;	\
> +	struct btrfs_fs_info *fs_info =3D to_fs_info(fsid_kobj);		\
> +	struct btrfs_qgroup *qgroup =3D container_of(qgroup_kobj,		\
> +			struct btrfs_qgroup, kobj);			\
> +	u64 val;							\
> +									\
> +	spin_lock(&fs_info->qgroup_lock);				\
> +	val =3D qgroup->rsv.values[_type];					\
> +	spin_unlock(&fs_info->qgroup_lock);				\
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
> +}									\
> +BTRFS_ATTR(qgroup, rsv_##_name, btrfs_qgroup_rsv_show_##_name)
> +
> +QGROUP_ATTR(rfer);
> +QGROUP_ATTR(excl);
> +QGROUP_ATTR(max_rfer);
> +QGROUP_ATTR(max_excl);
> +QGROUP_ATTR(lim_flags);
> +QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
> +QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
> +QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
> +
> +static struct attribute *qgroup_attrs[] =3D {
> +	BTRFS_ATTR_PTR(qgroup, rfer),
> +	BTRFS_ATTR_PTR(qgroup, excl),
> +	BTRFS_ATTR_PTR(qgroup, max_rfer),
> +	BTRFS_ATTR_PTR(qgroup, max_excl),
> +	BTRFS_ATTR_PTR(qgroup, lim_flags),
> +	BTRFS_ATTR_PTR(qgroup, rsv_data),
> +	BTRFS_ATTR_PTR(qgroup, rsv_meta_pertrans),
> +	BTRFS_ATTR_PTR(qgroup, rsv_meta_prealloc),
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(qgroup);
> +static void qgroup_release(struct kobject *kobj)
> +{
> +	struct btrfs_qgroup *qgroup =3D container_of(kobj, struct btrfs_qgrou=
p,
> +			kobj);
> +	memset(&qgroup->kobj, 0, sizeof(*kobj));
> +	complete(&qgroup->kobj_unregister);
> +}
> +
> +static struct kobj_type qgroup_ktype =3D {
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.release =3D qgroup_release,
> +	.default_groups =3D qgroup_groups,
> +};
> +
> +/*
> + * Needed string buffer size for qgroup, including tailing \0
> + *
> + * This includes U48_MAX + 1 + U16_MAX + 1.
> + * U48_MAX in dec can be 15 digits at, and U16_MAX can be 6 digits.
> + * Rounded up to 32 to provide some buffer.
> + */
> +#define QGROUP_STR_LEN	32
> +int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
> +				struct btrfs_qgroup *qgroup)
> +{
> +	struct kobject *qgroups_kobj =3D fs_info->qgroup_kobj;
> +	int ret;
> +
> +	init_completion(&qgroup->kobj_unregister);
> +	ret =3D kobject_init_and_add(&qgroup->kobj, &qgroup_ktype, qgroups_ko=
bj,
> +			"%u_%llu", (u16)btrfs_qgroup_level(qgroup->qgroupid),
> +			btrfs_qgroup_subvolid(qgroup->qgroupid));
> +	if (ret < 0)
> +		kobject_put(&qgroup->kobj);
> +
> +	return ret;
> +}
> +
> +void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_qgroup *qgroup;
> +	struct btrfs_qgroup *next;
> +
> +	rbtree_postorder_for_each_entry_safe(qgroup, next,
> +			&fs_info->qgroup_tree, node) {
> +		if (qgroup->kobj.state_initialized) {
> +			kobject_del(&qgroup->kobj);
> +			kobject_put(&qgroup->kobj);
> +			wait_for_completion(&qgroup->kobj_unregister);
> +		}
> +	}
> +	kobject_del(fs_info->qgroup_kobj);
> +	kobject_put(fs_info->qgroup_kobj);
> +	fs_info->qgroup_kobj =3D NULL;
> +}
> +
> +/* Called when qgroup get initialized, thus there is no need for extra=
 lock. */
> +int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
> +{
> +	struct kobject *fsid_kobj =3D &fs_info->fs_devices->fsid_kobj;
> +	struct btrfs_qgroup *qgroup;
> +	struct btrfs_qgroup *next;
> +	int ret =3D 0;
> +
> +	ASSERT(fsid_kobj);
> +	if (fs_info->qgroup_kobj)
> +		return 0;
> +
> +	fs_info->qgroup_kobj =3D kobject_create_and_add("qgroups", fsid_kobj)=
;
> +	if (!fs_info->qgroup_kobj) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	rbtree_postorder_for_each_entry_safe(qgroup, next,
> +			&fs_info->qgroup_tree, node) {
> +		ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +out:
> +	if (ret < 0)
> +		btrfs_sysfs_del_qgroups(fs_info);
> +	return ret;
> +}
> +
> +void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
> +				struct btrfs_qgroup *qgroup)
> +{
> +	kobject_del(&qgroup->kobj);
> +	kobject_put(&qgroup->kobj);
> +	wait_for_completion(&qgroup->kobj_unregister);
> +}
> =20
>  /*
>   * Change per-fs features in /sys/fs/btrfs/UUID/features to match curr=
ent
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index 718a26c97833..1e27a9c94c84 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -36,4 +36,10 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_=
info *fs_info,
>  void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info=
);
>  void btrfs_sysfs_update_devid(struct btrfs_device *device);
> =20
> +int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
> +				struct btrfs_qgroup *qgroup);
> +void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
> +int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
> +void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
> +				struct btrfs_qgroup *qgroup);
>  #endif
>=20


--C9YmGwwzj1UvvOoXRiTFfxJHVQaIiqQYr--

--4ZyWuUajz9QaWOpDoT9wWz6L3igjW2mCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7saBsACgkQwj2R86El
/qgthQgAiN8HFBnWiG/zV2ze1kfjaNgMysv1gt3fkWjKTv+dFX+GrbkKF6tdgCUv
QDRZsiIyvkWgi/DbuIz7Qc5Z4mNzzfWSU5dZgzWsa8tACudlE0pSTKIqNZWwAjsn
pyIQFrnsRr0idp5ehgMpF6cdd3Vd07ZfjZ9rZ8bk37UMWzjB+y5qMv4YNfXhyRYC
SqsSGsWWBDc+X3zHKTNwmO1VigbYOq38u1YKbWajKlkbxDnfA3CLwrNC7VZp0z+B
Xjt3OVWeJY0+epZT1ES7C4S1JD/z678qQ8+SNyXsnIxzoOMk9qiKtvjdTn9MzFgH
hu143E0qWk61TBdjN3EmStqQO9UFMQ==
=UNOY
-----END PGP SIGNATURE-----

--4ZyWuUajz9QaWOpDoT9wWz6L3igjW2mCF--
