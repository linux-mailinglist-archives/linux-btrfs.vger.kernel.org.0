Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CC4C62FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 07:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiB1Ged (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 01:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiB1Gec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 01:34:32 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18C66C81
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 22:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646030032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otxycBWTPWwl3NpZ4r2G8tI6GuGly+aPxZarVv05oKw=;
        b=duml2jLH6eOfAZDMWcyzRzQzbUuasb1ea2jc9V2A0CU83wy1VaL84+uI6zmFvEnRH7wphM
        dIs7AJtXiaUyvZVzeiKYrSB5lt7quHdrhoSBjBetVeyhjqcsX0aymVwhRvUk6SKpOUQWwY
        Z9wBBVxqLynLxzANZMjHog6bmqOI9PM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-hOzLyBEjPuGFe5nRMkOEHA-1; Mon, 28 Feb 2022 07:33:51 +0100
X-MC-Unique: hOzLyBEjPuGFe5nRMkOEHA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuOG6zqheYSKeo5kqt3yq2bHOTkcWBMtly4d9/WQhTS8SX0sbpiZGd6qPYKbcmStb20iI7Kcz7jW5TiAW1T6zAUTATHuiT9qXdR1jyiXFP4gGW3GIpZojHxRnJLQ9EMLQ874twXV5leRYTpp2icslZudE19korm8j/7eEmcyBjslxJ8A9dDv3l8Uw3MwFV5JzvAjY6kifx3E0ROwGtwibaW6F0+aBNpAN1i4ZwQR4O72CIatQpcMuhG1lNRoqnirCbTBJVnKFboDG0YKguUgY6J5yBjfo1ubSo7kn3Jm91zK58GtFc24Irsqpzx6ZCWz9u6/4C1CEiDDzFFf2BpyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwTLxWBtmeEOL+c+NFVSAf03sajqQt/kobvNThA4Usg=;
 b=BnaHOhlKfCeqnuWDtkPbbinntrbJcvhL70i+PRBIix0f25C6uv3Iasgydubjf2hohDLiYgAdM7Z9BsU7dhoiWx4N5pbaJqS1AvFJo50jh/6N62/CAMGur2eBCOeVHouMpATdd15bdh5sR9sNGl+KS3ty6/cW6HVC5oO9Murn/c/WBTZCU2CZEL+qjzin3KNHlLOwMsrfEzZuq8jPKxxFcTi4VMKXOFI1ljIdvBhKD5n0qHkNNP7Cncd4uBt+13PwaMr3Jr6+HF9xvcYBar8clnXe7ikThZf3fPRCaGTkkG1kqWkHxzzdSPkl+WPJ8hpYaX/Zkrm7v1iqSUO9NrndMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR04MB4081.eurprd04.prod.outlook.com (2603:10a6:208:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 06:33:49 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.5017.025; Mon, 28 Feb 2022
 06:33:49 +0000
Message-ID: <2ea80755-05ce-251e-bf5c-0abc9b0da45f@suse.com>
Date:   Mon, 28 Feb 2022 14:33:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
 <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
 <75c0e9c7-165f-3a4a-dda1-ebd0cc092392@gmx.com>
 <7d7dcef9-93c0-59f9-b553-f15b6a443f0f@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <7d7dcef9-93c0-59f9-b553-f15b6a443f0f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::24) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a534c9e0-c5fd-4cc2-d863-08d9fa844744
X-MS-TrafficTypeDiagnostic: AM0PR04MB4081:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4081C660318AEF3C74896DA9D6019@AM0PR04MB4081.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVyQtUkI6xxpckjjW+VC4mqkJQ1cUzrYRSkta9C0dMvk8AKNwSel3U4JIw29G4WmE+nwwpcNQ/4m2qHT9OQAUbjAT9VGFphJnUtqkvuaPBIxP0D8Cn/seIWKabErP6CV33LXGA1royJ4rmwB5Bu0ectXxi8wmIce2FuMTe6s/GjT3grA8f+kv+kkVpRXw6UtHkJPQL9OHgI2yuGspjR+n/h7/PgaJb4W7zBw1wYnLTV8kCs/lQv4uIVDgZT6asF6q5MLcjmsKJHAzSpxw5rOR+8PB6UAAtQ2r/YxTnLBjiPAWET7YT9AZlS8tXPrIobd3Yi5bLI8NhF/12qDRbC0zjNJEEvROEYyRS/qfkPNHa2RVnJO/m4q2wMmE2Tzta0rhCmL6b3Yl8DkT3QROD4jWHzz8G7F7f3pgzwkzzLMa5PTqtIN+wSa6NETajKzpvoIaWNg/qirnoqeQXBYG9Ougtllo7YiLznVlJXpS3hcshzrnMXZq9M0woU/FEeGq8oI5oh3gs4EQ/EbioO3Fc1YGu7lceYp8dl7XaMGEkFJkDliT0tiP3WPTjHI/4WtLFlsxUX/rUIz0jTI1JtNmGUYnHjBxW33eKtrkOoIhJF4nisc9pIpnKWJ9v4wbhYhFFULAUTxGbcL0KWO3/Hr3TCm5nbXqRJ/czjBgo7GU/GiX+maOvAGQQHP40zfXAeg7IgSpeqsGU5HVSKA9LYswuN2CSps0BtCTVDXPeghQq2wgJwTIisTPtR1FM0nyuyURloppqiiUscm8OIbb6z84GyWmUwBlHNBASTPjQ0IpYD9zitvW4mQlcpJqJZohsmH0GFc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(53546011)(6666004)(31686004)(8936002)(6486002)(966005)(508600001)(6506007)(31696002)(36756003)(83380400001)(5660300002)(38100700002)(110136005)(26005)(86362001)(8676002)(186003)(66556008)(66574015)(2906002)(4326008)(2616005)(316002)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7LGmLH1SVuuByJ9BrezHc91CiT6JnwpunMf6i2m3+aazqkv7+pAEyB5Zm6L?=
 =?us-ascii?Q?G64Yc7zeQsVPHCdsESIEugd/p42zzPOcGyUwZ/SU+3Tcf9zlh5ZH2qK70NoU?=
 =?us-ascii?Q?6rUe/ootHsk0pU3HeGm5rsLSLWkIirlPvVv7OB79CBbc1PfUxFTs3RDssahV?=
 =?us-ascii?Q?dbgwWTBvXNvSl3jxbQl44/9vWwRYQ7JaqQKMGmziWu63O5KME2Skqg+pkQyp?=
 =?us-ascii?Q?kYE2uIwyhdP5p5+O1uewwEsUJj3iDtaP/1GINuaPzMbXdcHMztfZeQ62iA/4?=
 =?us-ascii?Q?B79glqOYS/6K3SOftLko2auwc5DL0gTy6h/vb34pydHhULYSRzgWhbTQCU+o?=
 =?us-ascii?Q?1lBMFgHU1fTLB+Tk9EN8HfTmmztCcLneK3XAI+I0T+0flqck7iN78oaxjZiD?=
 =?us-ascii?Q?cXswer3k+i4CYl7y+kJ/vfwwuvESRF7iisKg8hM7DX56y4hg8Guj7ql55HEx?=
 =?us-ascii?Q?fhKo4zDlUrKtQMOrJPF1TsJRNHMdMEGUAueURqu4ZAErzVtgSGvBUT6LtPQc?=
 =?us-ascii?Q?bJ4U1EztpFMtrDDWBMP2eR4wEOVeBlPTRPd0TpEP2t7YtzSp7tpM8yKn+BLp?=
 =?us-ascii?Q?N+rnpHQWrgO6Ehs038kgEOJMuBCMS0BJO7O3hPc7T5VomN2h6HuV2dI0AYiX?=
 =?us-ascii?Q?BVbw0YRLRhlH7kekcfg7iApxtSPmaZZfBElHAOhaYnbKc+8xxnoVcA0K44wK?=
 =?us-ascii?Q?2arKD0RRcCLp92nCDfLaCN4P8Ub3V4FtiFk+uEamtSMkgButcQLx0YpzKlLq?=
 =?us-ascii?Q?qxfZmLgdx53Ut6YBhN8fBap7ZvADswm2EgTId+OQw6VS/KUePnd8aYoacxwd?=
 =?us-ascii?Q?ijIIFdpJ20xFYlAZ6Z2+EdGPFY9HCtrJjV9hO/snXwvL5i37QlsbzueldZhF?=
 =?us-ascii?Q?UDnSBTt649hNFnMCOTDWTauTJBnJbpw3ql5RF5czYwO4Z2d+28QJrnDp7aoJ?=
 =?us-ascii?Q?dveYkDsTFubXMPfPqz4yzbnE5dRqRnja9JQFbZPKVhshNrFBB14aEvAwDKxM?=
 =?us-ascii?Q?hh8OfXApuGDymYrxqmt1AVYP3wK5Rw0hlUUENdVLMdjcF6g3OuxbT1UysVyK?=
 =?us-ascii?Q?F8wrHjC6RfBAQw8YrblS+q8DoPfDYxVf9zyxn2UlilXKCEc/fuqRC122aLG0?=
 =?us-ascii?Q?kWjmfHILzYqdRXgNRxseP8bM/0O3KdgKFZ7aD3hPaM7+JfdrvSbQDiBa78Dh?=
 =?us-ascii?Q?/NAd4aA7CibnMXui6iz6eUxbLB+IOadJ8fX7jTr9c0Ug1rn4vt807qvzlIaC?=
 =?us-ascii?Q?vdrzxD5D7WnL3lcLWcOZOH8cRE2bWpYL1bLnsV2oK15Nw7KXVr6JcTsJtu8O?=
 =?us-ascii?Q?J1z0MVFqCVSUUp1xUHsA+aOAOjZIgcgiNh6e70ihjoJobJcN56VGyQaqCVW6?=
 =?us-ascii?Q?ouqK1adPVgwQB0WHnveNro6zL/0k0or8jxa/zi8M90AKi0EvNc1ftmhzhhxR?=
 =?us-ascii?Q?+GnN6Cxg7RBwriV4Fc1yolAah7XHq6KGyPGuwI7TF9OESxR/oW6mty5WDSYx?=
 =?us-ascii?Q?DCgx+mXBxqZHf/0ZyuAuNjeZbox3iGJV2JYd2uRuUPMwOUik4D6sWc4Z96jP?=
 =?us-ascii?Q?esTfAZQ3BNOeCkMDxNA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a534c9e0-c5fd-4cc2-d863-08d9fa844744
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:33:48.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQXYPbv6VPIBqKVymJJMXReP4eMDc8lmgbqnZxvuhnEmhVboj07HnwTtBujUI9eG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4081
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 13:49, Anand Jain wrote:
> On 28/02/2022 11:17, Qu Wenruo wrote:
>>
>>
>> On 2022/2/28 11:08, Anand Jain wrote:
>>> On 28/02/2022 07:51, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a report that a btrfs has a bad super block num devices.
>>>>
>>>> This makes btrfs to reject the fs completely.
>>>>
>>>
>>>> [CAUSE]
>>>> It's pretty straightforward, if super_num_devices doesn't match the
>>>> deviecs we found in chunk tree, there must be some wrong with the fs
>>>> thus we can reject the fs.
>>>>
>>>> But on the other hand, super_num_devices is not determinant counter,
>>>> especially when we already have a correct counter after iterating the
>>>> chunk tree.
>>>
>>> Cause analysis is incomplete, given that SB write is the last. The root
>>> (and thus chunk tree) and super_num_devices will be consistent always.
>>> Do we know how the miss-match happened?
>>
>> Sorry, I should provide a full analyse on this.
>>
>> In fact there is a window in device remove path that we first remove
>> device item in chunk tree, and COMMIT transaction, then decrease the
>> device counter (without commit transaction immediately).
>>
>> In fact, there is already a TODO comment in btrfs_rm_dev_item() call
>> inside btrfs_rm_device() saying exactly the same thing.
>>
>> Thus if we got a power loss/reboot, like what the reporter is doing, it
>> will cause such mismatch.
>=20
>=20
> If sb write commit failed. Why isn't root read from the superblock
> pointing to the old chunk tree with 3device items?

The failed trans is not the trans committed in btrfs_rm_dev_item().

>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>
>>>> [FIX]
>>>> Make the super_num_devices check less strict, converting it from a har=
d
>>>> error to a warning, and reset the value to a correct one for the=20
>>>> current
>>>> or next transaction commitment.
>>>>
>>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>>>> Link:
>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cWCOH=
5TiV46CKmp3igr44okQ@mail.gmail.com/=20
>>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/volumes.c | 8 ++++----
>>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>>> *fs_info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do another round of validation =
checks.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (total_dev !=3D fs_info->fs_devices-=
>total_devices) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch=
 with num_devices %llu found
>>>> here",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch=
 with num_devices %llu found
>>>> here, will be repaired on next transaction commitment",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_super_num_devices(fs_info->super_copy),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 total_dev);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devices->total=
_devices =3D total_dev;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_super_num_device=
s(fs_info->super_copy, total_dev);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_total_bytes(fs_info->su=
per_copy) <
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_dev=
ices->total_rw_bytes) {
>>>
>=20

