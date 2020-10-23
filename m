Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FA296DD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463074AbgJWLje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 07:39:34 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:38046 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S463036AbgJWLje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 07:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1603453170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cprNrRBaIiHK/+6PSKFSx2Rro+GeeOjirVX980ECFj4=;
        b=hFcn+aChqL1TjwnZXRt9aUwkSEzjh748KYD+pkDCg5XtPdiuBhmBx4F8UpFBQXChw5Zb7x
        WOZbFSoBy6EYdpxWJYVwQbu7OyNj6/r/FR20Jkdtz1qSDMiG1R7gC6FzwYvH6cqY5YJAY2
        a3+b6t1KuY9QIfY6+e5fNTYCV+ahJac=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-iel3RcRMPtub_dncynmF9w-1; Fri, 23 Oct 2020 13:39:29 +0200
X-MC-Unique: iel3RcRMPtub_dncynmF9w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC2xAr8DGL397eZgeEMEiDjnzfnKerixv+7Idz47vR4PJcGQtViXncyG1JBUKKH4MuhkLllLPiE6Zoe8Fg2CHfNwS/bxaozfOpcGdsZfqBnHhAdlcs4bkGGQm4UKX4yaALsEEAdGqw4i0jK6nDojWW469aIzPJLnHx5ahkBckEXUsGUH8d4E4+8qdDombBMoiz5vqPDIE8aAaMZqoZfx0qZE9HyfHV8xBYhCroT+ciMJpUuc42lOIuvzfJpJhD8KbjOl6g7cbtfb+kM62/fkGVqYqphl54KavTEmraqNy9Nn2qv+4laXK+buwDpuDs3HJCZOPmwLNC5pQ9f6YqLOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKUlaNeEnDM2vA5StXjnL0/ciAtgBDjbcLDHfXrO9lk=;
 b=S/+46KQB+Q/tlHonq8+H/8ghrSofb94dx5k9SH2FioDLd2s21e7CUGAcAy8QcG14XpHcuo6aj+0rNo+77iOJphZ1t5ZEw52dUJBHQs359r/ichUU1GwoVbvrmBIgRXxVuFksaltXbwe2YtV36yHxNNCkCi6H1r1lwtmz56yn9Duy/eWbFjz9zBSdSbpCbUlqHiwRV+NrDEgwIYVbr3MrBfhdWinu7q5ThJF01cbNR9tImjJv8bhdybAVjOVbYd0VaQCt7Ut2Ly9rj9WRD40pK3bryGWJbX3m2s2let15/Sccsa8ZiVAaj3ufvoR/AXGDFWvB1Fq2msaoeN06npq6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4194.eurprd04.prod.outlook.com (2603:10a6:208:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 11:39:27 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f%7]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 11:39:27 +0000
Subject: Re: [PATCH] btrfs: clean up NULL checks in qgroup_unreserve_range()
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chris Mason <clm@fb.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20201023112633.GE282278@mwanda>
From:   Qu Wenruo <wqu@suse.com>
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
Message-ID: <baf165cf-8ab4-9191-4a33-a0b6df735e47@suse.com>
Date:   Fri, 23 Oct 2020 19:39:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201023112633.GE282278@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 11:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b35c60f2-fed5-4703-6489-08d877484c10
X-MS-TrafficTypeDiagnostic: AM0PR04MB4194:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB41942CE4C383A19B648AC745D61A0@AM0PR04MB4194.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +STusywdq93+QTHkm0fAOntlwefhEt8p3ZKiAAbtK64C9jEz2CbTlHUgxUHrZPxo7oeR90nseNryEqWndHvv5M1QzOb20mbOBnpq0R4aiyNktMD7a66kXF2suOy0yjGdSM4BtOyLVjM3x8nJrM3mxTO3E9KVey0EurFpU0n9AFstziQJ+dKVEdg9ynlRpxj/zxQJnveWHeLCvQmyvNq3WWT5vyDP2gLd2RuzkJVfkV6nr1V5z8f0YFqG4k5FXR/xOwVfSKRyJmF6hC0g3whJqR0dcF2E/vEdCeJIycXUgSoXgb02aG4pq98PS8cuV8AdjWy+SWyTzbZigC4sF8nnVbjOoircIV6YO0DgI170dFHDvVlhyj/NG9MADbP3Y6cmKOatT6w3dJjKHbtBe/7nhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(6666004)(186003)(16576012)(8676002)(36756003)(83380400001)(6486002)(86362001)(2906002)(54906003)(31696002)(4326008)(16526019)(110136005)(316002)(478600001)(6706004)(26005)(956004)(8936002)(66946007)(66476007)(66556008)(31686004)(5660300002)(2616005)(52116002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GsLWZwYHJP3Yz4rjfkE3wv1CTfHdkQVtbDNUN8yQeByh5wIu17IBRC/l5/S+HLCeELzq+s/Qg4iZHhhHPMWk2xp4W53mKSslYDhypx0qno+GUq20/4woursXUlRHRl9oBon5si7fWbfyZkKO7sd0rrXnaVeAKK/zX7FEII7MgTjYy7KVhU3cQhFqkt/I9ap/EtlD4vborO3FkNuhnCVVwytpGvxAh8sixHNCUyKDCE6tOIF5V4N7L2YS86JAAWfihKz8ZDbBqWSY0+CYQJ3GxIKAe7s3Y9w+j0dirCOeLnjz/coIUMzeBs+7kopIWnilDrGXgClnzezN0ccV0Amaf4jnS/cVzfwrs9XhfA/BKiNi8GjwfkDttljgnx/9DHeOCfEsOw8E/yPwmoDbeiGMAQEXdkqZSI1IbDxmujMedjfgIRd1ZSVrjM9isZfiBYrUL09CtWbXIJ3k+CnUGG5q8O4LRxuWzMUCpzuK2wLTzH/Jto622CuRY3kSe0/ven/n0Xm6E6Lb5zlfgg4yyejVy+JbEn0S2MYB9/DD6Xob2XJlx5jpfjfWuseZH+dKQQ1BGvRY0BBhQYcSXSI8OH/isKJ8eyaKqvwMLOjJDOxJ6VQxtF4iwnkBJVXzK5sWCi40tCpVb/QyCeaddHEeHi3L9w==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c60f2-fed5-4703-6489-08d877484c10
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 11:39:27.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O5OuUr3tpXdg3pOrANeNCXI530HtZOeAPU5R7iY4WRseAup/5Vh3of4dP7mMQ0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4194
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/23 =E4=B8=8B=E5=8D=887:26, Dan Carpenter wrote:
> Smatch complains that this code dereferences "entry" before checking
> whether it's NULL on the next line.  Fortunately, rb_entry() will never
> return NULL so it doesn't cause a problem.  We can clean up the NULL
> checking a bit to silence the warning and make the code more clear.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> My patch does not change run-time, but it's possible that the original
> code was buggy and I missed it.
>=20
>  fs/btrfs/qgroup.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 580899bdb991..a7ae2f18f486 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3417,24 +3417,20 @@ static int qgroup_unreserve_range(struct btrfs_in=
ode *inode,
>  {
>  	struct rb_node *node;
>  	struct rb_node *next;
> -	struct ulist_node *entry =3D NULL;
> +	struct ulist_node *entry;
>  	int ret =3D 0;
> =20
>  	node =3D reserved->range_changed.root.rb_node;
> +	if (!node)
> +		return 0;
>  	while (node) {
>  		entry =3D rb_entry(node, struct ulist_node, rb_node);
>  		if (entry->val < start)
>  			node =3D node->rb_right;
> -		else if (entry)
> -			node =3D node->rb_left;
>  		else
> -			break;
> +			node =3D node->rb_left;
>  	}
Indeed, the new result does the same work, by going to the nearest node
of @start.

New code looks like:

while (node) {
	if (entry->val < start)
		node =3D node->rb_right;
	else
		node =3D node->rb_left;
}

is good enough and removes the dead break branch.

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> =20
> -	/* Empty changeset */
> -	if (!entry)
> -		return 0;
> -
>  	if (entry->val > start && rb_prev(&entry->rb_node))
>  		entry =3D rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
>  				 rb_node);
>=20

