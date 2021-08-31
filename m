Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7F3FC3F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbhHaHyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 03:54:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:56704 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239790AbhHaHyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 03:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630396394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWblB+Ph6VkxXQpp3b66g4qIrIMzS/ho8l1gAfnzr/I=;
        b=jGmDYVFqlBB/Ix0GjIUTaHXT99XIpLCsLDEIr8JJEQviusNaNupxkTwax4HemYC2P238/K
        ftDdnrYtUwAZhg8va3j01F2BmbmH0Cm3jkp1cmrFh1pprNJqNXX942zW3aUMBUDoAkvxJf
        2pPdSUZeornvFuVmNremAlxyXeLMmfs=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-Drb34mVUMD-vNa3xRklWWg-1; Tue, 31 Aug 2021 09:53:12 +0200
X-MC-Unique: Drb34mVUMD-vNa3xRklWWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2C1SZ7ceC5Pn90s/rqkcq84RM6oxSMIuDWtUW2wR+g52MHSIDc8NwuIhP//oZpBaMigQIdW+JJIaUMXR9RicknVuqeEQKFxABEAnkwNl5XZSatF0YXDDd4mlKC18u8Nlo/uGTrCwb5SGQ7kh6+I9yf1lw2dsBkqCHRVFyZKTRypDU6zb1G/4p72/VOIeLfUs874O5//59mpMbHdF8GsAzcZgnTvyhOe/rwtQC2T2nV29jAJ0izo16X3VCcuDMyY9cfXhBwhvnmHmnY/UaXxlhwv1eJO7PoPY263UldoPO3AlJK+jdHnQk37bKpMJ/96O2Em11qT0ucmYp2gjX6O1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVRtQMnLE9e2B7jAGsghuL8NH81x8/6/as3ARztKBig=;
 b=LPwGfnWSm7pJVIxDD0I6kfE3xWytOEpCVVDW5KAMfwKwmZSxPfF0mDb1ulNc7uIM6hEyEcLme0HtCyITbolmIzsC+TLvRfvCP0yvgHi5bLiD5ZDs2Kt/WEZYihJ79XbjreRTLvwmKcwMkf1v9iP81b6pWR+o08qYjkXhQ2DLor+L7p5Mpz3ibgpupDt3E2DJr0Va6xnMrBMwYwn6MpEcuEFrKNzQoOtulvzOOo26RrYtkeaLaKy+zyW0THamRhP5AqaK/tWFmR+6UIruMfRIqc56GtyDPrWfAoWSl5dzm/CCBF3ZWWMBP3EWBg45UWRO/UthtzkDKv8B92ZOEk16ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2900.eurprd04.prod.outlook.com (2603:10a6:203:97::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 31 Aug
 2021 07:53:11 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 07:53:11 +0000
Subject: Re: [PATCH] kobject: add the missing export for kobject_create()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     rafael@kernel.org, linux-btrfs@vger.kernel.org
References: <20210831065009.29358-1-wqu@suse.com> <YS3S5Nd5YW5pwcta@kroah.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <9236c202-03f0-e42f-e9c0-cde6a5bfad19@suse.com>
Date:   Tue, 31 Aug 2021 15:53:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YS3S5Nd5YW5pwcta@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Tue, 31 Aug 2021 07:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad491214-3b36-41fd-3a89-08d96c546121
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2900:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB29002C31F9078E08D2630892D6CC9@AM5PR0402MB2900.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiDXwxpRa7fv/D9MO36hHHNrUNy0xR5Ww+9dnIxoUAZuFee0Loct66A+r8AvZdL2ainCGu9Qe+O1sJ1YN5AzsABoVZ0hQJyG9q2cC3Zz/Q9XpXZ58KXyydeewAGRYMs0Vx2Fx9egEoiPv/NvyH/L6h4asOZ5P2kIrG4eza2SqFb6EHDeD20sQIhBVB+5dHqYTqG4p0nGVZDIS/zuYemSDXZ4qDZr5ccVGjmACy6/RnqmRdApXNI/t+zXcScem2oAFiIhqU0OGOtVmu8kzJ/DWeTgjzEdK8odz2x1Jg+DD/TrYymzc8wrP5d8neEStE/xqILreKYZsJeTDTkR2uWBr72I/UVM7ZP4vurvnbG/KyZXbZc8U7DJ45n16gSqLm9Ir94I43Pva3jlh3nxijp7nusQXuiXUdkpQcEi5QgukyZFl1yXIZOVBuYgFgwkyAWXNzMdiYtKX9Mp1hKDL4/tdoGqtl5Iq8E6Bkd6SgklQpEW4OpNvUyQ3pz2hh4v/Lk5t72hwZbwKG92H8mhyewET4cS/9KDjT+MZhI/YSIBTWBCb7XI7CblzhxcoYEGLSGRWU6wxsRN6j+IrWzWWSE2MY0K5sn4lPJbvYMVBi8VSMxmT13Dqni3a0MOdn51HWIGNgnzOg/IShLFSiPNsSEErtyj34vRQf+ndqXOvuru75uGCxw534zCOqfpnYRff6bJ7UTCNOzXLO5jFPnzGbcOi+xgXTzwM2iluGZVoPCb5nU867ZyAhWn6HiA+9tH2THE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(2906002)(66556008)(6486002)(66476007)(26005)(8936002)(66946007)(478600001)(4326008)(36756003)(6916009)(6706004)(31686004)(31696002)(5660300002)(956004)(38100700002)(16576012)(186003)(86362001)(316002)(8676002)(2616005)(6666004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GX5BJ9eZqUxbMwN5CKdS/vBqYhyzYKELC20ie4YVb7koRKhFtcHbt+Vwv7Eq?=
 =?us-ascii?Q?vbbKSaarmirNXMm4a2UZPYpPoFa3KSrlQYCn7NaLhfM/SFPTjfpYYXg5G0kS?=
 =?us-ascii?Q?2c9YnEp3od4BQV6PMVhQN1Ybh4j2GXD+09mg2XoKrZyDzt8FyPH505hdR3wF?=
 =?us-ascii?Q?4vXcqJ6ZI1NHjuFayPbSOkNBOhXdiKsTAU173lh3PnFf3t6hSIX/xaVWd0WJ?=
 =?us-ascii?Q?gj9NPPnM1c6tebQ5wudWtfB1ZTZl/YaggBGtApwqveWRbNzjKqRj+s5UMi9z?=
 =?us-ascii?Q?WuXZ2XTbPV/5XktpIsuMa2ecY4NGfalhqAfHTWmjBxLclymRgLQ4ne3hhynE?=
 =?us-ascii?Q?+ypIkGxL0oGMzT/9PtCWTjtzO/UwZGOjP/Y5y+OVpRRFULDFh6F1t4ednOxz?=
 =?us-ascii?Q?we1WjupvGTYRS7vBnAlPtmhQJe7LS+kR5h0cJC14F+kFPOfOyBTMa40YdpPj?=
 =?us-ascii?Q?dQpWOEnbxlnni1+Gg9wCAAzgel4K+paKVN2qi9ki5/B9REWlGVQO1GbAdQWc?=
 =?us-ascii?Q?7FGuweqDgcywh4UXBPnCLNCZx/HWiZgBIsCGsnhEIGX5/++lUv1sYyEE+MK+?=
 =?us-ascii?Q?Y7beMAHO788EoBrnFZzZYdwjuY+3EKgf7Y2zXOWryo4llJU1RqtFsDNH9EDT?=
 =?us-ascii?Q?lEwM0H64+eS6AZRjkemImLBzqSOGX3+YZYRVOG+MaD3wt/gSY8KyLYD604Gn?=
 =?us-ascii?Q?tvJdus7errdaUTdHfwGEbaYJF5vJMXLf0Tb71X0fSG4m2VBHsb0TG6kT/bFH?=
 =?us-ascii?Q?UzpanVqfmGocARvykZB6Z+pzDm1eCxC5AYdnBn0B9LOJogyB4B5sh+oDAZgo?=
 =?us-ascii?Q?ZxFFkPyoxJv3McNiXXAuhMecOLUitq/yqTjo5IjZmpfOdkX982rWFAqCVe6J?=
 =?us-ascii?Q?SdmrUnaDHdBmYBQ/BPFwJDob7RM+hWLBhufogWB++W3z6nxLDt51xkJ0BfV1?=
 =?us-ascii?Q?1VvHiAEWxDV+ZD4mIYzoDrhUNt8Tj5K/OwtkBb7VtkiDJIJ/vLPeP+aAWF2q?=
 =?us-ascii?Q?3+ouPwXxbIpKDew/BT33Wq00mxAhRB2MxmUdl3A9wcufSKVSRMIn0UHw5jUJ?=
 =?us-ascii?Q?fWx7uDsCVw9sOmGL/E5hNtY81U5QFsZBR3Yy6zLnlUdFQ5VxDIJ4NhNP/TpG?=
 =?us-ascii?Q?SyqJZh25FW8KZobjEo8uvmdZ7a+Zp5Ft5oDDXhpOG23yAMGsxzetvDooc/db?=
 =?us-ascii?Q?K5c7BhoO7KcqyrLB4gyqkTlnQ4uuOON4GiBA3uTVWbGYlhYFHWo3uP40ffzR?=
 =?us-ascii?Q?DwjLZ8546QFFho0wOzX3kWPTJqux1gA6F0rKJqbiGFy7rwlnIurF5vZ+6ZOa?=
 =?us-ascii?Q?LfE/A1l6P7AG8As4DK2H5L/c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad491214-3b36-41fd-3a89-08d96c546121
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 07:53:11.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xBsPwN3ezVPENmnmA9Y5eX53lI1sAMuzxSsyOeA6mJv8jmNcp+42ILvxRrLm/pb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/31 =E4=B8=8B=E5=8D=882:57, Greg KH wrote:
> On Tue, Aug 31, 2021 at 02:50:09PM +0800, Qu Wenruo wrote:
>> [BUG]
>> For any module utilizing kobject_create(), it will lead to link error:
>>
>>    $ make M=3Dfs/btrfs -j12
>>      CC [M]  fs/btrfs/sysfs.o
>>      LD [M]  fs/btrfs/btrfs.o
>>      MODPOST fs/btrfs/Module.symvers
>>    ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
>>    make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symvers] =
Error 1
>>    make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
>>    make: *** [Makefile:1766: modules] Error 2
>>
>> [CAUSE]
>> It's pretty straight forward, kobject_create() doesn't have
>> EXPORT_SYMBOL_GPL().
>>
>> [FIX]
>> Fix it by adding the missing EXPORT_SYMBOL_GPL().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> A little surprised by the fact that no know even is calling
>> kobject_create() now.
>>
>> Or should we just call kmalloc() manually then kobject_init_and_add()?
>> ---
>>   lib/kobject.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/kobject.c b/lib/kobject.c
>> index ea53b30cf483..af308cf7dba2 100644
>> --- a/lib/kobject.c
>> +++ b/lib/kobject.c
>> @@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
>>   	kobject_init(kobj, &dynamic_kobj_ktype);
>>   	return kobj;
>>   }
>> +EXPORT_SYMBOL_GPL(kobject_create);
>>  =20
>>   /**
>>    * kobject_create_and_add() - Create a struct kobject dynamically and
>> --=20
>> 2.33.0
>>
>=20
> What in-kernel module needs to call this function?  No driver should be
> messing with calls to kobjects like this.

But kobject_create_and_add() can't specify ktype if we want extra=20
attributes to the new kobject.

Or is the following way the preferred call style?

local_kobj =3D kmalloc();
ret =3D kobject_init_and_add();

Then I guess we should not export kobject_create() at all even in its=20
header.

Thanks,
Qu

>=20
> thanks,
>=20
> greg k-h
>=20

