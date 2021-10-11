Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75FA429988
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 00:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhJKW4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 18:56:42 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:28567 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhJKW4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 18:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633992880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcMBOWIxogZTnpkKwtxUU19WvRshSaAeWNADfc9221w=;
        b=dDkZ68EFUF6hI5Quy4zc+4OBQcVKmW9CCJjB/EjNr60e6UY+xXuk7Q8Oxb1dBZHzT8Vvj8
        QfjGhkjvoJMi5sFu9K1giUOFLjND/hvAbm9V+NDBuuLGRdSVVroKJ+R4F+ykEF4DNuQpy6
        1OSSOqkvdsVvSHx0JJP7Pwyo1CwG6Ms=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-2-7B1D3uHbMRO2vYjIz6oodA-1;
 Tue, 12 Oct 2021 00:54:38 +0200
X-MC-Unique: 7B1D3uHbMRO2vYjIz6oodA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neywSZh5YCljeK8K9WcZ1k+mMe20sgl+ip+l3kxexOF7WX5u0BSO1uC+CHcC2XMZYifXgYFZUVtCcJvq2tnGIBE08pAtxG0Pj1fbZss2BDLt37zvfivGveeOsjawU7Gubj6h4qRsHctjxVFVndEcQKpwWg7gfTgJje/tb6XS0c4Z/CLHcc7QBKc4MkssWNEiozdVcRhhTyh4dROXuruEGbh2SQEuFImihGpCnWFAsDrv1taY3MFM3siLiG14Fy472bMwoGVh9epqpWz7H3xBuwcEuGeeY7kQfLmpCZullHTZGLFfBJc46pCNP35Pmul9Yl0bmUB9HEcsBU492SuzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcMBOWIxogZTnpkKwtxUU19WvRshSaAeWNADfc9221w=;
 b=LISpgB9XuPpm8/Hajj6gy8vYPu0jCPRPOmUjWTSSIdgzZDxqQqfdZx8qHJcTZLAkzx8Hm2mFq51KiAAZy/BlVHAXzW6dPjKSdQenC3Ljzbhjoe8XSl+CgfEwsduSHEzxsiDdWC0AFup03urCFZJ7Sr5egBxY/sgnBdoln2zsQFdcWp1wLyr3/yQ8KUBsOa9lzx6I8sV7Oleq4HD+EyhQVPnO5ZPjk0d/KqQ7Afa8zXn2Ue6ykkOps1bbislUW2DtNNw6FQW7P5NbCl2NalxZbAd3jXP+QeAr/f5hfr6XAG94XXDGBa8/zQjZ8T8MPYylWpY11jhHVrT3Y05XLvmgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 22:54:37 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 22:54:37 +0000
Message-ID: <08b3c39e-6aa0-78ae-e163-99209fa07b44@suse.com>
Date:   Tue, 12 Oct 2021 06:54:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs
 cleans up temporary chunks
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <20211011120650.179017-4-wqu@suse.com> <20211011143830.GK9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211011143830.GK9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0016.namprd07.prod.outlook.com (2603:10b6:a02:bc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Mon, 11 Oct 2021 22:54:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2639809b-d41f-444d-f6f9-08d98d0a19d2
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:
X-Microsoft-Antispam-PRVS: <AS8PR04MB77332C763E7774CE30A89083D6B59@AS8PR04MB7733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kN7jEK3uUr7INU6yBZY1MRBRVIeNkZQA42wki7YFE1GH7MEbJDj7flX4Drd3V0Be+PtJZJbpHVsnSy4mUdPCRIWmQhgnUgzj1uhbv9WEfZnQaxHwV+ZJjBkI8sUYgJk+D0mfQHyJDCBN/ongwWpNAENnEaMnsv0V/DjkC9Pl1hcecn2XfrDvksvHOh8n1ZvjaHsj2pE29AJH8hErkWYX+xPe/BLJ4EaTL2RaUgx+bdy6sPItWxp5CoHP0qY7iDyDzIX8Umt59KWrZOVlwWDwYh8WL1EbBtFdw6VQatn1VfMu/irk3rlFwV+In9qgdj6o87LYtZ+5WdpZo1gU0ZWogHLLs8ByRTisbF4zUcRbmTm2lQRUnnfOA3uWJihYETCSdfhLYSyTN/QkaIVq71GsRj80xmJeD5squqvBex2Sq4loevR2O3aVspF47CBtVsrI1nQdrf2Z+PAOFoKSXfEzaVaplAmI1OnyKR/fMzNdkdpaYKeLTpQiqhmFt+V3hy3ESSR2yj7JRpXvXfYUhXpcUHt0zNjPZvD5bdDWDon2mtMIldcqDwuJGkt6sOiDsvjAW+ZmqqXcc2zT8P9CjG/hkBXCF39v5nEkMBjcho7yF1IeZh5fLcQ7dyPbl1bccPhZSmi6lnEDzlqWTXGaQWbPw1+6JZlWHY/ww1o0JzTgNfUDfb+BRDgUFgbOLKgGw0GbWKnlGCgQL+TKhHUSC0Ew2t1Wf/gA1MuVInFZljqDyLRcEv1EZEMX7HH/ozptm46e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(53546011)(38100700002)(16576012)(508600001)(8676002)(6486002)(2616005)(26005)(186003)(8936002)(36756003)(83380400001)(6666004)(66946007)(31686004)(2906002)(31696002)(316002)(86362001)(6706004)(956004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZKZnNLR0w2aFd2bXNXaitDdjYyekYrcGhCK2h1MG1TM0tZVU5nbkRzL0FO?=
 =?utf-8?B?V1J1M2JydFVieEdxdWhqbCsrRlllMkRLeE9DN2hGcDd6cER5akh4Q0pZQzg1?=
 =?utf-8?B?T3pTRkNma210MDJsdmRUdU1TN1lseTNFOHZTbEVlaGRzUDEwczVsVEh0MGlh?=
 =?utf-8?B?QUxyTE00ZTFnaEJ6RGR0WGhrUkhKUjBZVDhNMnB6NnpSUU1TR0o0eENSblN0?=
 =?utf-8?B?bEIwWFpvMGtTcmIramFVdzY3VEZUcVh0UkdKUjh4VkRKcmQwZ3Jpdk5MU3Y4?=
 =?utf-8?B?Zzd5OGYydkFsNE1vRm51em5yWlV4U0lZSVdpRkFWWXpaUWZMcHRqNGEzWG1G?=
 =?utf-8?B?Q2N4SU1tajJ6eHNMQWdqRGhWc0JtdTRjK0cxcXUwYlNkWnl0b2txZ1FIUTcr?=
 =?utf-8?B?d2gvNmZ0RFM2Zmo3SDQ2cDd6STlXcGxUVTNxYVB1NWlBRzlvVXl2c1hZN2c2?=
 =?utf-8?B?VG50aFAwSWltVEZ1SXBoWjlBSmdDVnNVckJyUk1rWFJLSUhYWDJRVEFDUkFT?=
 =?utf-8?B?VHBiTEdzZXNWZUdQMEw1Uk02NG0wWm1Bbno5YlNoRmRKR09QeFM2M0p3WmU5?=
 =?utf-8?B?RHBFdW5WRmJFVWppMCtORTErNUZJV2FNdmR5RWh6dWxPRkl5SVRPK0pjK2VP?=
 =?utf-8?B?RVBGbzlaSTcyZVdkL2MvZ2tWaklma0JtdWgvMkdwWjRFUXU2L28rRzJ5RzJC?=
 =?utf-8?B?V09lWHNyQmJ3NnZmRzI2ZjhZVWdDaEFUd0Q2ZUNwaEJyQ2l0bWNSeng2dk9J?=
 =?utf-8?B?T1duUWtkekcxaUcvUk12bEVBUmZabURpTTA2Qms0ZUtLUG41VGZ0aGZWb3BP?=
 =?utf-8?B?cFp0aGlDd2hNYkx0eVVVelh4aVpTN0g2Q3hDLzUrZjNkcFRUVzl5WmIySnYr?=
 =?utf-8?B?NWlacWFKdVd5aERqalFFUXROcDJtejgrQ0RhMjhOYnJBOHhyYWhoZlc2dGUz?=
 =?utf-8?B?VERLMTlGWDlwaWVYNVpjM2F0VFA5cDAwekZhTEhsY0lWMTdBWGdqdEFucC8w?=
 =?utf-8?B?YXEwQ0J0Y2pORG02cno5RXZDNHRreWxraUdmU2RsZnp3NG5LaW80V0I0a2Np?=
 =?utf-8?B?WERFcjFXMGp1YW1HM0JIZVlPVkJ1c1VtNHlEZnlIZ1hUelFaWENqZEJrb0s1?=
 =?utf-8?B?Z000MjJjYzMxVmZ0NnNHNkt1R3U1VXpMVjlPNGd0TU5Ub1lvcCtpdmIzcEVS?=
 =?utf-8?B?WTR6VjM0VG5iM25maDFrMlgzNG9QOTdmeGlEUGt2SlpRdjlEbmovdWowOXdo?=
 =?utf-8?B?SE5qV2FRQXFHRHJVSFc2SWV5dzRKMUhWbUZEc0xoeGp1YjVHYlpKVGUvTVRa?=
 =?utf-8?B?UHZYMUt1aTBzWEpQRUhUZldSNk5WeVlLM2RobDRwOGgrdHZTS04yaTlhb0pz?=
 =?utf-8?B?TzNqUHdPK0tvWFJaTWhFcVVPdk0xckU2TWllcXdwUlg2T205ZW9mWWlIVHZJ?=
 =?utf-8?B?cHBud3FmeWxMZHI1bmd2UitWd3BQM2w2Umk4dUlCVm01cW1kMUxaTDQzblVa?=
 =?utf-8?B?N0lEamJtbnI1c1ZGcEEwMWFOOUtnczgzbGp1azVxNFVjNCtVOWFXTGZhL3Fp?=
 =?utf-8?B?cm5OM2QyOXZjUm01dEJ5M1ZLbGJIak8rWCtMdHF4dXZlVXdJSjRGUFJDVFNW?=
 =?utf-8?B?QUwwbnByOHVJdVRqc2x0bU9ibnI1S05qMmtHR2Y2RE5pNUh1a1RieTNPbElO?=
 =?utf-8?B?Sk5ERXhsem9pRGpiQytHU0lzdVNTanhkcnBqLzEwdXl3c0krTzBuTy9BbERR?=
 =?utf-8?Q?iBVaqErci9Eqe4qUca385UdWoE+xD56GuptD3A3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2639809b-d41f-444d-f6f9-08d98d0a19d2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 22:54:37.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LzkTh4/m4Dp+kH/z2YOuqh4hXUA5arIsWzO+4ihmlUnO72f/lusIWXfaehTu3+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 22:38, David Sterba wrote:
> On Mon, Oct 11, 2021 at 08:06:50PM +0800, Qu Wenruo wrote:
>> Since current "btrfs filesystem df" command will warn if there are
>> multiple profiles of the same type, it's a good way to detect left-over
>> temporary chunks.
>>
>> This patch will enhance the existing mkfs-tests/001-basic-profiles test
>> case to also check for the warning messages, to make sure mkfs.btrfs has
>> properly cleaned up all temporary chunks.
>>
>> There is a special workaround newly implemented in test_get_info(), as
>> recent kernel introduced single device RAID0 support, which is no
>> different than SINGLE.
>>
>> But for single device RAID0, kernel may choose to preallocate new chunks
>> with SINGLE profile, causing false alerts.
>>
>> Work around this kernel bug by mounting the btrfs read-only to prevent
>> preallocating new chunks.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/mkfs-tests/001-basic-profiles/test.sh | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
>> index b3ba50d71ddc..0be199749864 100755
>> --- a/tests/mkfs-tests/001-basic-profiles/test.sh
>> +++ b/tests/mkfs-tests/001-basic-profiles/test.sh
>> @@ -11,10 +11,22 @@ setup_root_helper
>>   
>>   test_get_info()
>>   {
>> +	tmp_out=$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)
> 
> Local variables should be declared
> 
> 	local tmp_out
> 
>>   	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
>>   	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
>> -	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
>> -	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
>> +
>> +	btrfs ins dump-tree -t chunk "$dev1" >> "$RESULTS"
> 
> Using $RESULTS is not recommended, the same can be achieved by
> 
> 	run_check btrfs...
> 
> Also you should run the "$TOP/btrfs" binary and use the full name of the
> subcommands, ie. 'inspect-internal'.

Oh, that's the debug output I forgot to remove.

Please remove the "ins dump-tree" call...

Thanks,
Qu

> 
>> +	# Work around a kernel bug that kernel will treat SINGLE and single
>> +	# device RAID0 as the same.
>> +	# Thus kernel may create new SINGLE chunks, causing extra warning
>> +	# when testing single device RAID0.
>> +	run_check $SUDO_HELPER mount -o ro "$dev1" "$TEST_MNT"
>> +	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
>> +		rm -- "$tmp_out"
>> +		_fail "temporary chunks are not properly cleaned up"
>> +	fi
>> +	rm -- "$tmp_out"
> 
> So to be able to run the testsuite on unfixed kernels the workaround
> makes sense.
> 
>>   	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
>>   	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
>>   	run_check $SUDO_HELPER umount "$TEST_MNT"
>> -- 
>> 2.33.0
> 

