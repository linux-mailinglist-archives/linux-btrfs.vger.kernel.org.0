Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831233B400C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFYJKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 05:10:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33202 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229839AbhFYJKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624612098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MzRzuj8KP5nvkjv9QQgyEMZxiQX1ssI3FNbSvZ7xBQ=;
        b=FiZH2QTTzbBjKwq18XHTrLkEh57ig9Iq1O8KZhlB2xlbuawfe/XtAHRp1LFnnZB0qoCMjG
        SlnplORlNgimeANObOGwwcPPJ6rNHJL9/rwG+2KglehTHgCcVMaZu8f99+zsV8a88o5HAP
        sbZosoyhWg63UV9RoMA7euBvVLD1R3E=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-Elup_EagPfOEwNKRMENLRQ-2;
 Fri, 25 Jun 2021 11:08:17 +0200
X-MC-Unique: Elup_EagPfOEwNKRMENLRQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRgpeMejC+zvVbig+Z/P7lUB/rf/jXtduDhzbATBwiurnJnpbAvCvlyFZiZuPTPuRfHYyXmt08kroj64XzZuL3nP4j7mo5xhHUM4y5alY8ts3qkVLvUYuloDU6HddSRnu+KHM6rKJ2JgBswjGr3BHLd1M93hCZLJrBfa8PlsysYYmCPv+6I6xu7yBEq0VafyYAXTEKSrnKRvCMCk83RMsCYH1Z14GcudCWGjerZwOOagJ/Res9ABWVvKP4u1RQm9njUaiNrNaqJclCMVOP+kpi46ADSr4Y/4w+zHUzzPNdfWrycxzuewGMxTrkCb9uy+29S8BkDxUC9jggLJQX42ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnsDilTHxZ4uN/gQg41hkjUCYQNWhD4lJFmAUF0LQLw=;
 b=XhSnfkfWMhqkyT7HoO2wG8UkEEYosVkaTqXKZCg2RjW4YcaOv9b1mylnX8wwdYO05dvU36hntJNQTM+Ym9Or+mKTgKT/peCDPlQGbnYOrC6o74UX9960EZe5QZRkG2oWuq8SmxLemNrAhS7p3U1R7z1d7paUPLjDeIMCA1Tby27HqnaiK9CKieDkVSSzRadHu/OL3wnTdqJDS3YIbiUvgkgjg5pPScppau2PhEBHLy8xxTCQ4vD3/CZKve+wxkN0jqAg7YPC+c0lxZCpaFtccRFF3JInEN5BMvFrz3qCBVKEv6SAU9T7VUWh5y01fQYsp7g6UWFpyBX+HXuCp//Wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4278.eurprd04.prod.outlook.com (2603:10a6:209:4f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 09:08:15 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 09:08:15 +0000
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: add the ability to detect
 and repair orphan subvolume trees which doesn't have orphan item
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
CC:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210625071322.221780-1-wqu@suse.com>
 <20210625071322.221780-2-wqu@suse.com>
 <c1606c68-c10f-9890-678a-ed2aaf10ad49@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <ad8eccfa-abbe-71f6-9c84-f930422f13c1@suse.com>
Date:   Fri, 25 Jun 2021 17:08:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c1606c68-c10f-9890-678a-ed2aaf10ad49@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 09:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60aca35-61f6-4c94-cbc7-08d937b8c40a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4278:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4278E529D773ABF68D38BD03D6069@AM6PR04MB4278.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8xqaSMpEhc26thInbpKmdXLCjBzEMUho/t8D2laIQWuIXnDxJQY8iRTmzanw9kWGcDxhptmpiFqpKRzEmzJFVEikB5BUVXRuTuuXTyAD8wKl5NZ8JzRKEiGgZaMf/H8HJ8wQCiSnVP2SUQETPD5OXRaniWHRrnsQLyoYOqqfUOqxsVUJcHFYijIUo5FsDVTeFrr5pSyE4eHHjpk8lRMRp0/Kcpkz/qgQnZ9HCK2IY7aXSyV05KyWPzCYtSPM18IChJJ8Pp9kxREZzo8/Yjj03xC3icLxJEJyzG2r5qNS5pkWavxI5pTucCZVXonKN34z5fkUwEs9Q/kmGkwTAbXb9zPxXYX9ykWRy2BJS18SdLQg9YASiMny/2nXybQoHjqLEG7yq5wwP3FZHQc0O1GsihgeOPFNxXicV+cbQBW9TSbTq9NQ994q5mGq6Xy08ntrUeHmm2Cv9HsfWpfpnSHGX17xFzAzYYFMv58XsCf4OCqR8FVe5kMnqZcJZOZbRuIkFSn/386Yp21Mf3lzgPLOaCkSBo1+Q+oul9bCazWY/zjfBGoeMOMG2+2hcSwF5sLmlR84V2Wr7VwJuVhaGVgVQntIDQtcClAWlrHRzI92JLPhLfyzXqABuHaBhqghy5tExlBbhe3zFys5OUieNdPEC7bRDKAP3BGCjBz1uHJC9RyGA8v8M72IYEZ1px5081KHVSrNOJca8qfszLOxb45Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(39850400004)(376002)(36756003)(66556008)(6486002)(86362001)(31696002)(38100700002)(2906002)(31686004)(16576012)(316002)(66946007)(6706004)(66476007)(5660300002)(8936002)(83380400001)(956004)(2616005)(4326008)(16526019)(26005)(6666004)(186003)(8676002)(478600001)(53546011)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTVA0UPdboXRyRg7G4wgRIo4rn7lPKZmalfLyUEp0jIAYrJEYrGpqCQSkLyf?=
 =?us-ascii?Q?PLCGKhiwH8saKdGXa9SpgIZMl6GX6jVq+A5vkSzvaABNIjpdw3j8T0jYq9jw?=
 =?us-ascii?Q?+wpS0maShCqNv3xXJkJxe8EQiVw9JzHgtVC+a/zUApV4gO8CGisn5BtZ+cwx?=
 =?us-ascii?Q?fc0nB6H6bTSFDYgGXjzhs/HqCGtgO25zy3yE4biON2fU9cy2hLMsEacaqROj?=
 =?us-ascii?Q?FtQC/DnE/O0S7ffxfMMzC7tbCwMr62ePo0ryOXJs3haedCBu7K7Grd+3gWMB?=
 =?us-ascii?Q?Mx3o9uXMssglhszxJcRV/Ctm0bkrSzVoRhVsD86YKz0xz1ZwUpxZ1EH84oD8?=
 =?us-ascii?Q?+LNySF4PaX1E1wkISfo+UIEZR9cyTPxzHH1848sUPCWAJFHD7t9sTEtq5f/1?=
 =?us-ascii?Q?3lF2hRaF5arkqNjeWGouI49Md0DQgVXZdFpTYaRIbTG51m/WC2RsXpLH6gSJ?=
 =?us-ascii?Q?w6uBxw6RML+9Fz69OniWCU0Q4A/i78C2nkgg6JU7g1vQCRNBpgSOLkkC8xm3?=
 =?us-ascii?Q?QY+EgE81rrZPEo1wvoXM5YN5MaCLJ8Uis8kkbVsAgLH6k3NGH9kGA2zYrcgg?=
 =?us-ascii?Q?m2ECLVAQA7ElelVau+/BZYSt/GdbEDO+vPX9ezt4fsbke3iANE1eG/LqDcSW?=
 =?us-ascii?Q?mWbYf+FrCxBl79pYbXOl74eAY+j2UNcjVuQCxXXEu84XH5xHJgVdEvdc9s6a?=
 =?us-ascii?Q?/qxXp44UyOQ45FCmeeqXPm2/k9weZRlFt1q/k54dUk8ScfO4x0vZZKekWl+J?=
 =?us-ascii?Q?dzXHpS7ZAtxFcha+oSB5dLKJ7JmDzegaFpW4xlqCtZljf6ipJu4bZVzzI9jV?=
 =?us-ascii?Q?I2sWU5jD5tUN83P3DVirrmLmswles9B9m/ZfUXOIxYcQc7ddaAyraSYJKXl9?=
 =?us-ascii?Q?zgToWV8NGboQ4Lzp/8GhWavcWyoq9Q2qKs2cwDMfIcPtPdNaCMIQKHGkJ9pQ?=
 =?us-ascii?Q?Z7/o5vc08piyDA0u4TcKvZH/3n+DUCJVbYFZNai4GaInFQvSNgtjz/BFuKYs?=
 =?us-ascii?Q?ePZTTZBGAt9z0MlMa7oQb2zn6K3vGgA30EWL7JxeMp0VD4XPI5Fogo8iEGsc?=
 =?us-ascii?Q?3voezr9l8FirIkie4bwdFJQ13jsg17bSLRDgtkrZxO9tpgoT5YJVxofJETsp?=
 =?us-ascii?Q?/6FRDQX9gh2nZKZ4+59B3zrJGcmKRzyyYOytmTNAWiz6pLGiI8eq1hsiKvuI?=
 =?us-ascii?Q?7kvY4r6wTCSotsK38xX2vhtV5EuAKsGfkaimPM5ruUQ61hzcg2TBARYtY5Md?=
 =?us-ascii?Q?mRFZQhk3RmBrrJNX7B7RQTE0mYpikun8Cx4SEDOfFa1jw8qcdu6UJVg6dxBY?=
 =?us-ascii?Q?LHT+xTJNernUF//GkgCjVIXb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60aca35-61f6-4c94-cbc7-08d937b8c40a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 09:08:15.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Zw9YvywutgKIvvHxL/zUfjJiwfswpvGeAtad5yLqfLowHt0L7eeIKNIbUriZjoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4278
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/25 =E4=B8=8B=E5=8D=884:58, Anand Jain wrote:
> On 25/06/2021 15:13, Qu Wenruo wrote:
>> There is a bug report from the mail list that, after certain
>> btrfs-zero-log operation, the filesystem has inaccessible subvolumes,
>> and there is no way to delete them.
>>
>> Such subvolumes have no ROOT_REF/ROOT_BACKREF, and their root_refs is 0.
>=20
>=20
>> Without an orphan item, kernel won't detect them as orphan, thus no
>> cleanup will happen.
>=20
>=20
> Changes here looks good. But what if, in another case, the ghost=20
> subvolume isn't an orphan but a corruption? is it possible?

Firstly it needs to pass all the other root item check, including=20
ROOT_BACKREF/ROOT_REF, and DIR_INDEX/DIR_ITEM.

This means if there is any ROOT_BACKREF/ROOT_REF, or DIR_INDEX/DIR_ITEM=20
referring to this inode, it should not be repaired.

Furthermore, after passing above checks, it must have a root refs as 0.

With all conditions met, it's really a ghost subvolume.
In fact I have to do all above works to craft such test case, thus it's=20
not resulted by some simple corruption.

Thanks,
Qu
>=20
> Thanks, Anand
>=20
>=20
>> Btrfs check won't report this as a problem either.
>>
>> Such ghost subvolumes will just waste disk space, and can be pretty hard
>> to detect without proper btrfs check support.
>>
>> For the repair part, we just add orphan item so later kernel can handle
>> it.
>>
>> Since the check for orphan item and repair can be reused between
>> original and lowmem mode, move those functions to mode-common.[ch].
>>
>> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 check/mode-common.c | 56 ++++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 check/mode-common.h |=C2=A0 3 +++
>> =C2=A0 check/mode-lowmem.c | 42 +++++++++++++++++++---------------
>> =C2=A0 3 files changed, 82 insertions(+), 19 deletions(-)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index cb22f3233c00..d8c18f6603bf 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -1243,3 +1243,59 @@ out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> +
>> +/*
>> + * Check if we have orphan item for @objectid.
>> + *
>> + * Note: if something wrong happened during search, we consider it as=20
>> no orphan
>> + * item.
>> + */
>> +bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_path path;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_init_path(&path);
>> +=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_ORPHAN_OBJECTID;
>> +=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_ORPHAN_ITEM_KEY;
>> +=C2=A0=C2=A0=C2=A0 key.offset =3D objectid;
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, root, &key, &path, 0=
, 0);
>> +=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +
>> +int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_path path;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_trans_handle *trans;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_init_path(&path);
>> +
>> +=C2=A0=C2=A0=C2=A0 trans =3D btrfs_start_transaction(fs_info->tree_root=
, 1);
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(trans)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(trans);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to start trans=
action: %m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_add_orphan_item(trans, fs_info->tree_r=
oot, &path,=20
>> rootid);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to insert orph=
an item: %m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_commit_transaction(trans, fs_info->tre=
e_root);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0 printf("Inserted orphan root item for root %llu\n", =
rootid);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +error:
>> +=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> +=C2=A0=C2=A0=C2=A0 btrfs_abort_transaction(trans, ret);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> diff --git a/check/mode-common.h b/check/mode-common.h
>> index 3ba29ecab6cd..c44815a171ac 100644
>> --- a/check/mode-common.h
>> +++ b/check/mode-common.h
>> @@ -192,4 +192,7 @@ static inline void=20
>> btrfs_check_subpage_eb_alignment(u64 start, u32 len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 start, start + len);
>> =C2=A0 }
>> +bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid);
>> +int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid);
>> +
>> =C2=A0 #endif
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 2f736712bc7f..1ef781ad20bc 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -2500,24 +2500,6 @@ out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> -static bool has_orphan_item(struct btrfs_root *root, u64 ino)
>> -{
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path path;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> -=C2=A0=C2=A0=C2=A0 int ret;
>> -
>> -=C2=A0=C2=A0=C2=A0 btrfs_init_path(&path);
>> -=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_ORPHAN_OBJECTID;
>> -=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_ORPHAN_ITEM_KEY;
>> -=C2=A0=C2=A0=C2=A0 key.offset =3D ino;
>> -
>> -=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, root, &key, &path, 0=
, 0);
>> -=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> -=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> -=C2=A0=C2=A0=C2=A0 return false;
>> -}
>> -
>> =C2=A0 static int repair_inode_gen_lowmem(struct btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path *path)
>> =C2=A0 {
>> @@ -2622,7 +2604,7 @@ static int check_inode_item(struct btrfs_root=20
>> *root, struct btrfs_path *path)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 is_orphan =3D has_orphan_item(root, inode_id);
>> +=C2=A0=C2=A0=C2=A0 is_orphan =3D btrfs_has_orphan_item(root, inode_id);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ii =3D btrfs_item_ptr(node, slot, struct =
btrfs_inode_item);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isize =3D btrfs_inode_size(node, ii);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbytes =3D btrfs_inode_nbytes(node, ii);
>> @@ -5209,6 +5191,28 @@ static int check_btrfs_root(struct btrfs_root=20
>> *root, int check_all)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Make sure orphan subvolume tree has proper orphan=
 item for it */
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_root_refs(root_item) =3D=3D 0 &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_fstree(root->root_key.obj=
ectid)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_orphan;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_orphan =3D btrfs_has_orph=
an_item(root->fs_info->tree_root,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 root->root_key.objectid);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_orphan) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r("orphan root %llu doesn't have orphan item",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root->root_key.objectid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
repair) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D repair_root_orphan_item(root->fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root-=
>root_key.objectid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_orphan =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!is_orphan)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err |=3D ORPHAN_ITEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_root_refs(root_item) > 0 ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_disk_key_ob=
jectid(&root_item->drop_progress) =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path.nodes[level]=
 =3D root->node;
>>
>=20

