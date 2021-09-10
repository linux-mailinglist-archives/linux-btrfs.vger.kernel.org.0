Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17264067A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhIJHaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 03:30:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:58792 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231473AbhIJHaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 03:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631258934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLVDuJJBz3RRZN0P905743Sl9XlVTykF6amVBbz6K4M=;
        b=D2RWLKvN7Vfjbnz2NKlKCNYs7roZnFvgQ1WiDBUlflXzAj1LD6RtMLMgocCLvrRC5ZjoCX
        bsrUJqNQGAmozTapT5ugraDw4dxaCKTl7uSYtG1RTuTnXtFOUDyFHqLMXePVZ7/JJsjVoO
        /rZ14kjdXTnXgNvyRdNiT92nfS63oKY=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-s1YiokBqMPG3Ik6PXWO1tg-1; Fri, 10 Sep 2021 09:28:53 +0200
X-MC-Unique: s1YiokBqMPG3Ik6PXWO1tg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZMiDIf4xvKaQd2XCuQNvydrj+zIvjrrkVPUQhYeY2APIgmlzdZHBF6Y23ycklzJZEe8llXIAz8lzm+TujT0zDJ22EporIwsWSFuafuSuGCa4LF+UYv3D6MDTKQhhZXw5/gEvZoY/cgW+oPopnLlaRPs6RJXWrvdTYf0xw26fi+X0EuLifF059nLAqSTT7zwB6NlwvNJtDCPB0pCtINo6bIYAqz08g5rZEB58g17GaX6tuaYFZFCIZ5V4zkV3re1i71My7jSLalQm9osrYMT00tXKuuFWi9cdqRgsvYLbmsG7TqIFEdARof7FHy5h4mYWC0kzma6UPWYG3pulpqj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9NWBsLT85rI14dj1zCgc1ixjEszcyx8S02v3UODdVtA=;
 b=JsTFdNQi9bm4f79GcA5dTX5riVqMnS9RveTjnKxhLB3ltaiiroqve+dOcsvfzZ1v2L2aweZtklJCatJKCRYPP9fjmxOhHsOms0pzOlpXkUncJ1DyF+zzhiHdwCv+om+TzLR3o89NmwQ8q7qOgJ5fHTZTisLIWAvfq/Locw4sdPHcphl+LJF92bhHyQvlTLqOU+SN+hsbMae8RJ0SNSH1Zbt/6RkdJuPPg05i8iQWwAIc02Oy8sB/14PIQxckpkJX6yNA8yo/0yDIlLLcL2yXlvqDCBzfBD7gIjbUfD03SA48Uv7A2NKaGlLzKTn07HLLbTNSEw1Q6J0+JH1iEet5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3558.eurprd04.prod.outlook.com (2603:10a6:209:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 07:28:51 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 07:28:50 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: do extra warning when setting ro false
 on received subvolume
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-2-wqu@suse.com>
 <e1dbfdc6-d1d8-12d4-cbcf-1dd02c935df4@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <81a72912-1e90-205f-c875-bfac50e80a0e@suse.com>
Date:   Fri, 10 Sep 2021 15:28:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e1dbfdc6-d1d8-12d4-cbcf-1dd02c935df4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 07:28:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2418213d-9398-430a-596d-08d9742ca292
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3558:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3558E314CB2B412A8C51DD38D6D69@AM6PR0402MB3558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Mce7uZOpXNj5K6zyzlt7HgG2usrg9E8D9h/aM1M6IWXxN0Z/aYKiqyrzkuoxOEaVY1vuN9AQI/AF1+9TCkbol+UpcvHq13WvuZYZVfSzGxcRSwYOWh0UUMvRnJPzAw9cAeLa+BzOzIZYBmwI7JovD/RllZ4agNSgJKRyI7yMs92JGu7WBE0gltVOYYI5YNIo+R4G4DtDmS5BGXkIJXhkZwRNsoaAhYqlzGSUACQPmIHAkujd2WPLj2k9yCmUsdgNU8Exj0wtfiOFM3HWiRdkQb3znxaZUtRIHPFpaYcVGyKZSUTcPhDfR7PtDOTeCU0GM2JK3K3Glykn9iUOLn2sL385mE+ZdWyX92Cki/u5hWcToNbm0xvkLKiyo1ZlQOMKUaOjCIZM30nnqN4cmvmchMTOBRKq0hOclsBoBHp0vdqWO8KixPyzPATnhiyqo9AeW8zmYHkkCWA41KbxnxLtMEuKRh/p6YDp/8YbQY0i9ziyXbNgoqGHXDzoQHn5BgrvkjFTkZM4oXeHj5C2nfrzfE2u5W93NXIMqqlfQIJd3+19M1mzU9e+FSoPy2LYoQlARfvcuKqd0bWrVlUQnvDhoE6hoxqPvbE4HL6ODMd3foga/v4U7O9wZOZ3+DqFEyjlvK93CO2xxr36MFZXX6Jp/M+ePPvMqAPDxIYhIvet8Y/OK9Uh6m4Sy7RQyHy9kwpcyLR48jxeByUYMvnzMS78Dbrat58qg7kZpmufklKktbxC7PD3v1lUEAhp0XDcRY6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(39850400004)(346002)(6486002)(186003)(478600001)(2906002)(8936002)(26005)(6666004)(36756003)(31696002)(8676002)(66556008)(83380400001)(31686004)(16576012)(6706004)(316002)(66946007)(5660300002)(66476007)(2616005)(86362001)(38100700002)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOFGhDFq3sIjMEVWWKM8FkPjLdW47aUW8jzw3LNyK6N0DizwtA0dU/8cKDeS?=
 =?us-ascii?Q?3n3SZArMpxoUHXqmSNCHkA6xYGwXNElfXMC4GPUSW2F1x3c/8AN/4VvYUHSs?=
 =?us-ascii?Q?Iqkf7NCMoMpSAKGlWsJtMROnMtHyFsVHLWYUf68hbytx7oRNbyVAr375aEy0?=
 =?us-ascii?Q?0ZrCQgjQvLUWiUQhN9AO6pKsMQiK6v63vRnTechtCYC85PUF/72traQGAG75?=
 =?us-ascii?Q?WQElfVX/kDE5cvth2ihSNqeBbOHv15bHguehg4k4s7C3DwS3pE6+G0SCs7G+?=
 =?us-ascii?Q?DZbpsVOUJYs03jrPfnaE2XB7X32sc7MYzWPnfyePooyOfY8yuk8cJNm2VEw5?=
 =?us-ascii?Q?oD5KcHL1wb2QRyuV3IKcMD0CpRxhI9VGC+x3ObUtscJe0d1wwrGJLQscCUaB?=
 =?us-ascii?Q?eFUcX8Q3I45lUOg2NHY1vyqllwjlZ+sMjffkvUCuBplmin+/QIN8iLLLFSlW?=
 =?us-ascii?Q?yDnTGxtXEyi15uGdMsazA1oyvleDOsyZB/5iht/stv5968jLkT0KVV8PyAlX?=
 =?us-ascii?Q?2asw6mid1lQYtZfcxzgJMm32UF81HwkSu4DZDYlPZsJbK2yPw6iR0ISjoRYN?=
 =?us-ascii?Q?0/gmTs2z+gDpn97mFaH0hVG/a5QZgi+sOrr9iIJVHTBN/YjN6f0vDav1ytwq?=
 =?us-ascii?Q?XxdlBzj/TTUEKVMVdnulVVQxLvGMtGpG2/mJVfZ/UwvEO0cVGmY5wTh6K2Nc?=
 =?us-ascii?Q?Xp1o0IzFD4yFyJOkV5di4bpRG/c806ZeIJ2kxjJAMRwOpCzB+29LyvRCzLZI?=
 =?us-ascii?Q?Q7rzYljpXxnjMmsycpkAzyDeWu6kCIJr8Qwm+A67i1PxGIse7YjIIKrZ9fda?=
 =?us-ascii?Q?UjcuO0uBAkp7dfeMQfBLwP3KlwldrCzK3T0Wshor2UCIMic2tT+F06MhLWrg?=
 =?us-ascii?Q?stgVfxIbjDL/XCtH8jyrK+hoyOVJaUcFUcdrJZWNKFiHq9L4tFxWtokCegzJ?=
 =?us-ascii?Q?KqreoVdKUxXk8q9L2gslP8E43ic4IKlmJLbPeUcnZVRCxDdnMq6fW92VB/+m?=
 =?us-ascii?Q?xrGF5+3F3l/v2fR1aVcPCQ7cw6cyVFDu/YQtQLiJrniKSKmzK95mQBkl8EkM?=
 =?us-ascii?Q?tlI+m/2gNWk7jSLSH80w8296bLUDghmiz22FWxSUjkcRsYdPijglBMlau3E/?=
 =?us-ascii?Q?JU+8mStYCRP16Bxe3ed7DvCCZeAWYn1BqS9HwkBm34YZD8zHcXjbz7JHXLOz?=
 =?us-ascii?Q?vPabNzK/G5ajtjjL1OGg/vgSe/9EsAHQLfqe4auq4tKk7STQqPEx5CL1VR6R?=
 =?us-ascii?Q?brNBGg/EOyw49OMXg6oEUfg/Urv3REv1EM6D0KyFsMefNK64x9qYsFTMNlie?=
 =?us-ascii?Q?MLEnTvzQ8yjQbIzSpGA6wGZL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2418213d-9398-430a-596d-08d9742ca292
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 07:28:50.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1W1KZHgNjmE6/TAmh9yMimX/ORMKCT4eSMPnhcJKBx9wtPeFK1jPuiBh4fPD18Oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3558
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/10 =E4=B8=8B=E5=8D=882:36, Nikolay Borisov wrote:
>=20
>=20
> On 10.09.21 =D0=B3. 9:03, Qu Wenruo wrote:
>> When flipping received subvolume from RO to RW, any new write to the
>> subvolume could cause later incremental receive to fail or corrupt data.
>>
>> Thus we're trying to clear received UUID when doing such RO->RW flip, to
>> prevent data corruption.
>>
>> But unfortunately the old (and wrong) behavior has been there for a
>> while, and changing the kernel behavior will make existing users
>> confused.
>>
>> Thus here we enhance subvolume read-only prop to do extra warning on
>> users to educate them about both the new behavior and the problems of
>> old behaviors.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   props.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/props.c b/props.c
>> index 81509e48cd16..b86ecc61b5b3 100644
>> --- a/props.c
>> +++ b/props.c
>> @@ -39,6 +39,15 @@
>>   #define ENOATTR ENODATA
>>   #endif
>>  =20
>> +static void do_warn_about_rorw_flip(const char *path)
>> +{
>> +	warning("Flipping subvolume %s from RO to RW will cause either:", path=
);
>> +	warning("- No more incremental receive based on this subvolume");
>> +	warning("  Newer kernels will remove the recevied UUID to prevent corr=
uption");
>> +	warning("- Data corruption or receive corruption doing incremental rec=
eive");
>> +	warning("  Older kernels can't detect the modification, and cause corr=
uption or receive failure");
>=20
> This is a bad format for a warning, let's keep it simple - just state
> that flipping ro->rw would break incremental send and that's that.

But won't this on older kernels cause more confusion?

The old kernels will still allow incremental send using that flipped=20
subvolume without problem, just corrupting the data..

(Well, that's definitely "broken", but still a different behavior)

Thanks,
Qu
>=20
>> +}
>> +
>>   static int prop_read_only(enum prop_object_type type,
>>   			  const char *object,
>>   			  const char *name,
>> @@ -48,6 +57,9 @@ static int prop_read_only(enum prop_object_type type,
>>   	bool read_only;
>>  =20
>>   	if (value) {
>> +		struct btrfs_util_subvolume_info subvol;
>> +		u8 empty_uuid[BTRFS_UUID_SIZE] =3D { 0 };
>> +
>>   		if (!strcmp(value, "true")) {
>>   			read_only =3D true;
>>   		} else if (!strcmp(value, "false")) {
>> @@ -57,6 +69,15 @@ static int prop_read_only(enum prop_object_type type,
>>   			return -EINVAL;
>>   		}
>>  =20
>> +		err =3D btrfs_util_subvolume_info(object, 0, &subvol);
>> +		if (err) {
>> +			warning("unable to get subvolume info for path %s",
>> +				object);
>> +		} else if (!read_only && memcmp(empty_uuid, subvol.received_uuid,
>> +				   BTRFS_UUID_SIZE)){
>> +			do_warn_about_rorw_flip(object);
>> +		}
>> +
>>   		err =3D btrfs_util_set_subvolume_read_only(object, read_only);
>>   		if (err) {
>>   			error_btrfs_util(err);
>>
>=20

