Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDB20A8D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 01:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407816AbgFYX2J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 25 Jun 2020 19:28:09 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:33402 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390973AbgFYX2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jun 2020 19:28:08 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 19:28:04 EDT
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-66FTVvBzOtCMIMhsu_CCDg-1; Fri, 26 Jun 2020 01:21:43 +0200
X-MC-Unique: 66FTVvBzOtCMIMhsu_CCDg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab2WHTy8n3745HFBPw/OFJkSg2tIZqC/4RXH0Kl12jeM4qs5WuKSDn1+YSZwRxg2yvBSqQl8tFgD0zkL2mem3WjU9lJ1KXWD9BNi7S0h0BjjhUPR9cgBTMaRKloYZq0QgWrBqdk7rBcSeM0lNrWkY2s3rW6nqoML7152Ore4aT1T88yQnVAlGqTwjxiYOPgv/TP3LKBLz9Z5sJx3NR5CAOpqiUKEoC/1StOw8hj98QvAtnF6fwd+QGr36+NsRVAHQTWG14Oh/0A9kb9RuyOrz4Zl1h0RWuVID3+mvcYxIyFCNinJQLo/NFJzlZiDviNluuwWqQ79SDgaARqBhfGoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeoZxyaLxa8Mpn2GVYhN15ZPMFThvAFdfcWFv0EqSnM=;
 b=T6Ozj5/k6gIaTsqWwRvCkqyCfJJwCG7H9E16GldDlyETMDJ417ZlghUg4noaCrsW4flH7Xdbbvjf0/Vyn1LrD/Qa1g0Oo/wZ5k5jqy1tOQ6vM3Co/Sq/l6TRpatJ6so9De4F/iZBkEVex0duvhmVyEZHr/cchsFNUxLy8pIANoc7+nKz2y5o+/Gf/dQ5o0nzsHIQ5E8ZJkfAyOYCG/Zy4rgAnvgHug/YQEd+PNW+qhWaoSk6XUInRwpkUYvdvz4PBnb8LuC5LFzd5vDm0Xh1LX5+NNoTlAeBoFqjPzzr1XglyliZ53vKlIibgVGgOaxWp3MjU2BN4ta/Phj9wAAZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6206.eurprd04.prod.outlook.com (2603:10a6:803:fa::19)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 23:21:41 +0000
Received: from VI1PR04MB6206.eurprd04.prod.outlook.com
 ([fe80::d115:670f:dec8:146d]) by VI1PR04MB6206.eurprd04.prod.outlook.com
 ([fe80::d115:670f:dec8:146d%2]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 23:21:41 +0000
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200625202120.GZ27795@twin.jikos.cz>
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
Message-ID: <5b2a9ae4-115c-28dd-affa-92b238929a15@suse.com>
Date:   Fri, 26 Jun 2020 07:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200625202120.GZ27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43)
 To VI1PR04MB6206.eurprd04.prod.outlook.com (2603:10a6:803:fa::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 23:21:39 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8965eb6-3b93-4e20-6b37-08d8195e841e
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:
X-Microsoft-Antispam-PRVS: <VI1PR04MB303983B08055A05B26860285D6920@VI1PR04MB3039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODlDh+z5MruCszxMMg6lrmnmZvq1n3ZSE7YXsRgNCcpGaTVJIgnD/xJj5/8dyevEzN9HHtygq/VFKEd0n84Kyxuj3q4vB01awHwOFU08VuZjGxlKnYcbcvzT6u2YkMfpPbaNj52+mOYCWzhTktf5o9oIr66NISy9BdruvLkU+q78BlPXrz6M6cub6de/U8yNAJ/po/1z/9yAC3FrDq4zJIhiK71iqxviekbD60A87snjlTqVQuL36+lWT+TJII75X051/RpRIcGM0XdenqEGfXyy7phL7CdqET77nTV3BPs86vCUsmtQWOkdH9QweR5nah6iLzfNhUd9GHWFskS49i8o8Od80Vskr20k5ySPMC1nXpiEA5dO0duGjgBJvxqSMCCxF96OMCtArm5WXJB6p4tQNGRGxR5H60xDxYNOvksdfPaYOsQqCD7VTgOCV59m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6206.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(66946007)(66556008)(52116002)(6706004)(66476007)(186003)(26005)(31686004)(16526019)(956004)(6486002)(16576012)(2906002)(2616005)(8936002)(8676002)(5660300002)(316002)(36756003)(83380400001)(31696002)(6666004)(478600001)(86362001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: L8qCYP18eCMKKe/Nb6gMmsrZjMHs962gEafJchd8XxmD9yp2OVLjGwGYKW/vCOScrK8iEWkYBhj4UK4Ltu2V9RcEhZKrmQLm9+nfnSPxaOB0q6Y2lW27xySMwu/+Of3d7pS7K4kAI7gYzMtVXdKn/VTgVZiuF6kgff4jUEuAjU289FP8nco4xFvv0lXVv+/H67aO2FnpokzEupTmx3J4pYMp7z/V2Q4es4TqKPSCXIAYSkEBCEujeFL3h4OsbAeA73QQv/uhjqTPUOoONvjvGZpySrkpmBACO4WPieNPBbkotjhSyUxERnn4dUsLcr5jvUgK5X3OmIRcf4pwPMlOwDP4dkXiH2qS5us2e90Wwrpd0C19IS37EgmRw/kkE3T+y9mFYOhxiLZlqi094qL6c9PjAUxH1/038hbGPW9sMyhX8E/jdgAB4SCfSVvX2FTsRWOfn0DjomE+UrHcAh9F/UM07hXeLMPcY0lavBIXMa8=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8965eb6-3b93-4e20-6b37-08d8195e841e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6206.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 23:21:40.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3phs/SEojHUwEsD0ckTosf7HseR1bakzfycR5Kko6mdDhV04uWrECPkhthTbmkNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/26 上午4:21, David Sterba wrote:
> On Fri, Jun 19, 2020 at 09:59:46AM +0800, Qu Wenruo wrote:
>> This patch will add the following sysfs interface:
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rfer
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/excl
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_rfer
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_excl
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/lim_flags
>>  ^^^ Above are already in "btrfs qgroup show" command output ^^^
>>
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
>> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc
>>
>> The last 3 rsv related members are not visible to users, but can be very
>> useful to debug qgroup limit related bugs.
> 
> I think debugging should not be the only usecase. The qgroups
> information can be accessed via ioctls or parsing output of the 'btrfs
> qgroup' commands. For that reason I suggest to pick better names of the
> fields, rfer, excl are not self explanatory and we can't change them in
> the structures. But we can for the sysfs interface.

Sure, I would go "reference" and "exclusive" then.

Although for rsv_* they are really for debug purpose, do they need
rename too?

> 
>> Also, to avoid '/' used in <qgroup_id>, the seperator between qgroup
>> level and qgroup id is changed to '_'.
> 
> This seems fine.
> 
>> The interface is not hidden behind 'debug' as I want this interface to
>> be included into production build so we could have an easier life to
>> debug qgroup rsv related bugs.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
...
>>  	u64 new_refcnt;
>> +
>> +	/*
>> +	 * Sysfs kobjectid
>> +	 */
>> +	struct kobject kobj;
>> +	struct completion kobj_unregister;
> 
> Why do you add the unregister completion to each qgroup? There's a
> pattern where the parent directory wait's until all its
> files/directories are released but I'm not sure if we need it here.

It looks like I'm a little paranoid here.
Since for qgroup we always release all qgroups then the parent
directory, the wait is not needed in theory.

> 
> The size of each qgroup would increase by about 100 bytes, which is not
> much but it adds up.
> 
>>  };
>>  
...
>> +#define QGROUP_ATTR(_member)						\
>> +static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj,	\
>> +				      struct kobj_attribute *a, char *buf) \
>> +{									\
>> +	struct kobject *fsid_kobj = qgroup_kobj->parent->parent;	\
>> +	struct btrfs_fs_info *fs_info = to_fs_info(fsid_kobj);		\
>> +	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
>> +			struct btrfs_qgroup, kobj);			\
>> +	u64 val;							\
>> +									\
>> +	spin_lock(&fs_info->qgroup_lock);				\
>> +	val = qgroup->_member;						\
>> +	spin_unlock(&fs_info->qgroup_lock);				\
>> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
>> +}									\
>> +BTRFS_ATTR(qgroup, _member, btrfs_qgroup_show_##_member)
> 
> The macros need to follow the patterns we already have in sysfs.c,
> please have a look at eg. global_rsv_size_show or SPACE_INFO_ATTR. It
> reads the main pointers and calls btrfs_show_u64.

Oh, that's great, no need to bother the locking part.

But do I really need to follow the to_space_info() macro? Those macros
really bothers me, as it's not that clear what we're converting from.


> 
>> +
>> +#define QGROUP_RSV_ATTR(_name, _type)					\
>> +static ssize_t btrfs_qgroup_rsv_show_##_name(struct kobject *qgroup_kobj,\
>> +				      struct kobj_attribute *a, char *buf) \
>> +{									\
>> +	struct kobject *fsid_kobj = qgroup_kobj->parent->parent;	\
>> +	struct btrfs_fs_info *fs_info = to_fs_info(fsid_kobj);		\
>> +	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
>> +			struct btrfs_qgroup, kobj);			\
>> +	u64 val;							\
>> +									\
>> +	spin_lock(&fs_info->qgroup_lock);				\
>> +	val = qgroup->rsv.values[_type];					\
>> +	spin_unlock(&fs_info->qgroup_lock);				\
>> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
>> +}									\
>> +BTRFS_ATTR(qgroup, rsv_##_name, btrfs_qgroup_rsv_show_##_name)
>> +
>> +QGROUP_ATTR(rfer);
>> +QGROUP_ATTR(excl);
>> +QGROUP_ATTR(max_rfer);
>> +QGROUP_ATTR(max_excl);
>> +QGROUP_ATTR(lim_flags);
>> +QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
>> +QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
>> +QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
>> +
>> +static struct attribute *qgroup_attrs[] = {
>> +	BTRFS_ATTR_PTR(qgroup, rfer),
>> +	BTRFS_ATTR_PTR(qgroup, excl),
>> +	BTRFS_ATTR_PTR(qgroup, max_rfer),
>> +	BTRFS_ATTR_PTR(qgroup, max_excl),
>> +	BTRFS_ATTR_PTR(qgroup, lim_flags),
>> +	BTRFS_ATTR_PTR(qgroup, rsv_data),
>> +	BTRFS_ATTR_PTR(qgroup, rsv_meta_pertrans),
>> +	BTRFS_ATTR_PTR(qgroup, rsv_meta_prealloc),
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(qgroup);
>> +static void qgroup_release(struct kobject *kobj)
>> +{
>> +	struct btrfs_qgroup *qgroup = container_of(kobj, struct btrfs_qgroup,
>> +			kobj);
>> +	memset(&qgroup->kobj, 0, sizeof(*kobj));
>> +	complete(&qgroup->kobj_unregister);
>> +}
>> +
>> +static struct kobj_type qgroup_ktype = {
>> +	.sysfs_ops = &kobj_sysfs_ops,
>> +	.release = qgroup_release,
>> +	.default_groups = qgroup_groups,
>> +};
>> +
>> +/*
>> + * Needed string buffer size for qgroup, including tailing \0
>> + *
>> + * This includes U48_MAX + 1 + U16_MAX + 1.
> 
> What is U48_MAX?

For qgroup id, the upper 16 bits are for level and the the lower 48 bit
are for subvolume id.
So here we use U48 here.

But since the define is unused, it shouldn't be a problem any more.

> 
>> + * U48_MAX in dec can be 15 digits at, and U16_MAX can be 6 digits.
>> + * Rounded up to 32 to provide some buffer.
>> + */
>> +#define QGROUP_STR_LEN	32
> 
> Unused define
> 
>> +int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_qgroup *qgroup)
>> +{
>> +	struct kobject *qgroups_kobj = fs_info->qgroup_kobj;
>> +	int ret;
>> +
>> +	init_completion(&qgroup->kobj_unregister);
>> +	ret = kobject_init_and_add(&qgroup->kobj, &qgroup_ktype, qgroups_kobj,
>> +			"%u_%llu", (u16)btrfs_qgroup_level(qgroup->qgroupid),
> 
> %u does not match u16

But my compiler doesn't complain about this.

Thanks,
Qu

> 
>> +			btrfs_qgroup_subvolid(qgroup->qgroupid));
>> +	if (ret < 0)
>> +		kobject_put(&qgroup->kobj);
>> +
>> +	return ret;
>> +}
>> +
>> +void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
>> +{
>> +	struct btrfs_qgroup *qgroup;
>> +	struct btrfs_qgroup *next;
>> +
>> +	rbtree_postorder_for_each_entry_safe(qgroup, next,
>> +			&fs_info->qgroup_tree, node) {
>> +		if (qgroup->kobj.state_initialized) {
>> +			kobject_del(&qgroup->kobj);
>> +			kobject_put(&qgroup->kobj);
>> +			wait_for_completion(&qgroup->kobj_unregister);
>> +		}
>> +	}
>> +	kobject_del(fs_info->qgroup_kobj);
>> +	kobject_put(fs_info->qgroup_kobj);
>> +	fs_info->qgroup_kobj = NULL;
>> +}
>> +
>> +/* Called when qgroup get initialized, thus there is no need for extra lock. */
>> +int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
>> +{
>> +	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>> +	struct btrfs_qgroup *qgroup;
>> +	struct btrfs_qgroup *next;
>> +	int ret = 0;
>> +
>> +	ASSERT(fsid_kobj);
>> +	if (fs_info->qgroup_kobj)
>> +		return 0;
>> +
>> +	fs_info->qgroup_kobj = kobject_create_and_add("qgroups", fsid_kobj);
>> +	if (!fs_info->qgroup_kobj) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	rbtree_postorder_for_each_entry_safe(qgroup, next,
>> +			&fs_info->qgroup_tree, node) {
>> +		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>> +		if (ret < 0)
>> +			goto out;
>> +	}
>> +
>> +out:
>> +	if (ret < 0)
>> +		btrfs_sysfs_del_qgroups(fs_info);
>> +	return ret;
>> +}
>> +
>> +void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_qgroup *qgroup)
>> +{
>> +	kobject_del(&qgroup->kobj);
>> +	kobject_put(&qgroup->kobj);
>> +	wait_for_completion(&qgroup->kobj_unregister);
>> +}
>>  
>>  /*
>>   * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
>> index 718a26c97833..1e27a9c94c84 100644
>> --- a/fs/btrfs/sysfs.h
>> +++ b/fs/btrfs/sysfs.h
>> @@ -36,4 +36,10 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>>  void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
>>  void btrfs_sysfs_update_devid(struct btrfs_device *device);
>>  
>> +int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_qgroup *qgroup);
>> +void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
>> +int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
>> +void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_qgroup *qgroup);
>>  #endif
>> -- 
>> 2.27.0

