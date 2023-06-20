Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC37360FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 03:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjFTBHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 21:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTBHw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 21:07:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4802FFC;
        Mon, 19 Jun 2023 18:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhVif+zVk1qO4nEolJvX7rhq5U0iPi38iFtuXpP0QEny5+ADbNGWG6s30HHCzXzKMUI+IfksVhsqWjtT3ViJUoOtAIDDVGyXM4PWrsiKw7Lz9hO55suliEZZVeaGx6cinVXFrjKHnZB2n38uYDk2qZGd9EyRZKRRggQQx0+TInklncnQHIRJuM5Y1bn8F4obpSKh/5XAIHPq/3jGYlzWKb2PZ/mZWV9NxIIC+vojmyC7QboqtluMESVOYjwe5mspVf9jnKLeboWyp9ldRbvfI38dfqMLzGGjUxbCu8OOb9Dz1/FNWdxCpVTZH8ifqRuMc8k8/bkIT2lWmGitQNxzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USAqG3JqmNBWJ1y5elsWdNU018MqWkNCBusRVnya9vo=;
 b=VGYn4kRmKyzzY5PoshjAjV1AbXUVFrxT2QueM3FAQYDm5XWKSAStY5gSuTOvvpNghdI6kKBr7hHgAKDvuDKx+C3aKOU4OGsjpRhnCEFRURRw2a36beJrXyCJMncYumcTzs9sdCuQHuv6c+b3becti1cMmRw3A1Srv7XXb+Pas84p9vQaPtfSaQmkdB20BIf/BuvSZfLR5MkF0ZidSkktKVTDe/vNqFsfhdPJlW7Qsj7qzgn/PvqzTt5tba3KEGmMV17QV12O4H8HYetRYvUO9Ljn1v2PZgPpX0FK5OoxuPrpLd17DgzrJe6EyE48lwqN8m34KaOyceYujOtIcuI87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USAqG3JqmNBWJ1y5elsWdNU018MqWkNCBusRVnya9vo=;
 b=RMZxVkopKfyo71AhSbv34/mSqf0tEo4FNRxKO42yisK7XrZX3xtVsjEHcYanxSctHp/964i7g/oMbAuplGw5K4xBgiBnYFPMNvxqmgIKNMqBt7xgWL6PAisPO8GGh0uKADXAwgdE4kzAB5BFJlRaBzzcTVE8VEX7sVmQnM/z1DUDbp5gK4jAXNG6dZVBihfuCgjnNv1wZ6wlRV79dtLbI2MSMN2oZT75f3MwgtdCaK44UMb5fZhQIaFzapJgzyW0nlAJBcc5wdfpNsO840zw42zGBE2PdQSm5M1sASB0878m52N3YN5+Iyg89zXrQKtlEIQZKxRjWBPTCQEOo2uscg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB9209.eurprd04.prod.outlook.com (2603:10a6:10:2f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:07:46 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 01:07:46 +0000
Message-ID: <3ea45213-fd95-4027-8a95-066b07fdecc9@suse.com>
Date:   Tue, 20 Jun 2023 09:07:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230608114836.97523-1-wqu@suse.com>
 <CAL3q7H6VhahmpcWZGpfauyUmrG76kqAyZAMQb8_5T74Xyg6U+A@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H6VhahmpcWZGpfauyUmrG76kqAyZAMQb8_5T74Xyg6U+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d150cf8-e38b-48d5-134d-08db712ac1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OocS/voaiMwTBz/besRg2AM/xfgcvuEoAgQeSdzsNKSBEB8bW2OGUW9tvJu2blXIL9IZpsrlhPDqs54Ui0vJ60k58H7c6wsIHDGn9jbQ80wuvYaS5xC6f+o5UB7oRzb4mgMEApJDLCWs5aW0ELM46HIA0oIwr+zmXxjLb20jvqrPD1zZk3doyJQoK49C01Iqz0F1BZu+b2rfww0pB1DBuzFf8NcKczbWdie4Dx6txs4YS+znaAvKQP3g9C+sa345YZdm7FvnfFTOMK1FPQGK01pM7ijd1KsAd3HZ1v/eX9XZ1lz/bNHxS5d6bReCNGFJ+ETCFOE3G6c8rRNZ3p+Gt0XT9ScK9lZdY2FhXsUvf+d1kZz8OLZ1oF1cZs4h4BB4oiYe+mnBbDWl5DGCr5geyusQ9VeBBeWVS4g3fCxwn8YsG6SiwlDcneJ6uK8N98hZ+jauSD7Kc2uE2CFauOf0nCNI2Is1bNSOvv2afmTNoHPo2qWCiOA8yWP5/YHkeEeBKI5klqAgCAxio7j59X84rG8I2ywuPi9sOiZooH04Nw/7G293NkJ5NmR/RHOABhXXZmc0cpjAVsBLBq5QcBrsh4E+ySyOHz4b6Yc1gvkikb1R6Z0OI07BA9ZtmAYnCqvWdFtB6mCWD9p5lKB0emGo3WvCIZf7UjRZxH6b6Ee2mrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(31696002)(31686004)(83380400001)(86362001)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(66556008)(66476007)(6916009)(66946007)(316002)(2616005)(53546011)(6506007)(6512007)(6666004)(186003)(6486002)(478600001)(4326008)(2906002)(36756003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5MOGI0Z25YbGZBdkUxRHE4cTg4aVdMeGZmeERLd1FOSW5USTZxelNkY1dy?=
 =?utf-8?B?aXVVUmlEMHV6RnFwdENQVlFDcGFiMXo3ZG1pVWxBUmRSOEN6MU9JMk5DcmVu?=
 =?utf-8?B?NHBwT0p3d2JsOEVhU2JKRHFwbW5FdTFKcVlQZm5KNGdocmNtNVFHTyszbzNO?=
 =?utf-8?B?ZGcveWJqNUdUTG81V3VVRnBPWGNqRDU3azZWWTRJUnE5b3dBZnpSWWNUYnN3?=
 =?utf-8?B?dmdnWEJRY0hPdFpsN0M4dmRlNTV4eTN3RTY3TmFEZVlKdk9UQVRqQlhTc1Q1?=
 =?utf-8?B?K1U0M1k1RXJKVDhzeGVrSnJWV2VqT3pyc2c2R2NzNDBtQ2Vxc2tkR2Raems0?=
 =?utf-8?B?VzhOYmVMc1dzMndpTmhTOGxFUjRGalJPWis4azVmem8ybE9jZWtYVnJpVVhD?=
 =?utf-8?B?UmpVYXVTQmV2VHpYRHB3Y1NOT2FFZ21wdkVLSnRIYm5BR2k2bXl4WG0zWGhB?=
 =?utf-8?B?aXV5ZFV1Q0lxRWsvNnlSWnhJNFUraFlKRklaN0VMUlZYQkx2RGJ3YXlDMVVR?=
 =?utf-8?B?a1d6WUprSzhtMUY1ekNBSnBGa3E1RTBaZk44RVFhbk1XRTdray8waWh6dFJi?=
 =?utf-8?B?L0NpMkltVHZURlpLVnBJU1J6bXlWWS9TR1RXa3NYN0JnQUtsU0hLc21CTGJK?=
 =?utf-8?B?YmQ0cjE1NDRFaUFhSTdsdUdZenFVbFhwWWpEVFU3MXpzQ01oWTlqR3MzWlNU?=
 =?utf-8?B?K2k0OGZENnhpY3IybDlBOXZxcUNHMC9UNVdrWkhvTndhc2VYUmVocFdpOWJB?=
 =?utf-8?B?VFNhblc0SFZYRXNWend3N1VhOTIraXBVamVYZnlhbHJMUk4rQ0ZjTnQ0NWtI?=
 =?utf-8?B?MHJIMFJSSTJCejJzKzhnajdsNVMyQ3p0aXBnU2FNemxWOWlpWXBOaG0ySjMr?=
 =?utf-8?B?ZWZ0b1lBYjg2QkZMaFhxWXZJK0l4SFRobzgxZjVZdHNNekdJWkkyNG5EMVhP?=
 =?utf-8?B?VXVMUzdoWDk5eStYWVNCS0k5cGhDUXRvY1JLYUpQTEl6WjlRUXJPcFl6THU3?=
 =?utf-8?B?YlI5WVZ2Q3hNMkZBelRRRi8vZ1BSdjl3dzVtejhtK0N6QlJQWGJaSUZEd28v?=
 =?utf-8?B?MVJSZCs4cHk1OHl0WVBCVTJWM0I5WSs2eXluV3dvbTdSYVloWnRPRGJvRGZS?=
 =?utf-8?B?ZFBic1pWVWF1dHdUOFZXZlErK1VYQm42OEYwdEcxeVd4aDM1VG84ZmIzRStE?=
 =?utf-8?B?dDlaTDY5NE9TYm13ZURHKytRVndSRlA3N2tWamJWQkhkcWhTQngyL3hBYTN4?=
 =?utf-8?B?Y1B0em1GeEZYUS83azdTVFE0UGNWdXRUNWRWVzJCTytQL1k2Ym90VzJuL2Jo?=
 =?utf-8?B?NzJ4cWR6RWVZdU9Nb2QvVjdwTlo0SVJOWFJsdWtLRXlRUjdzNkFGVTBIcm93?=
 =?utf-8?B?V1E4blZqMkpsTksybDl0azNHbXFVOHlxMm9abEZMWVpyMlo2ZDlkbGtlVEJa?=
 =?utf-8?B?WUp3SGtSYXRsWG83QWprd0pXV2U2SExybTZNdUYwVlVhY0taRE82dWJoWE9u?=
 =?utf-8?B?azhDZXlScGk3bFFHUmNEdG1VL04xWnFlVmVrZUI2bFd3aHpaSVN2MlBFS1Rp?=
 =?utf-8?B?a2RUbU1SajVsUWlYT1F6S3I2QUJIK1d4SkJ0WnRKcW9jZDJ6MDBJOFoxQmxD?=
 =?utf-8?B?c3hvaElqc2w4YVVkRnBmSUxub3RDSlg3RU95bkpCUmhYNXZhOTBpVzNIL05H?=
 =?utf-8?B?M0NRNjBCaW9jSmhlRkttdERKQXBYNTk1N3NtM0ZXbmhVNkNBczRScEFhNndh?=
 =?utf-8?B?clRBZUd4K0hGL1c3bHlGaXFSNkdqLzBzMldBaHgwbXh4dFVBcXZkOVY2YVRl?=
 =?utf-8?B?ZjUxejVuWlh1d1BDdGZLSlJ3d0hHQUF4YjNNbVFGZEpUOEU0RytzTWduTmtF?=
 =?utf-8?B?aWNIS29CeHpKdWg1akVCRlVCY3RFMTZ4UTR6ejQycXBvRm94R3JabjRnZHAx?=
 =?utf-8?B?Nmcza3dta1dUNi9SNVROQU45bVFmTlE2bkRGb2RGcXREMU5mUWtOU25UMStY?=
 =?utf-8?B?aExOZ3pKSXJHT2F1RHRreENEOTZmOWE3VzIyclVDK0R1R01raUp1aFNuRWFh?=
 =?utf-8?B?UjZqRG1CZEttUzU2NUZmM0h2SEczSlFaTFpVSUM4SFFLNHpRWVpLWnZOQUpX?=
 =?utf-8?Q?7TADwkdnxnXMwvlgV8o8hG/QY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d150cf8-e38b-48d5-134d-08db712ac1ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:07:46.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEN09bN6MFaELi5K6i4TTpeZW+igEZYXwFa1DpnIPTsgcn0vEqtJGSNZhIcuPZCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9209
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/20 00:13, Filipe Manana wrote:
> On Thu, Jun 8, 2023 at 1:02 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is a chance that btrfs/266 would fail on aarch64 with 64K page
>> size. (No matter if it's 4K sector size or 64K sector size)
>>
>> The failure indicates that one or more mirrors are not properly fixed.
>>
>> [CAUSE]
>> I have added some trace events into the btrfs IO paths, including
>> __btrfs_submit_bio() and __end_bio_extent_readpage().
>>
>> When the test failed, the trace looks like this:
>>
>>   112819.764977: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=1 len=196608 pid=33663
>>                                      ^^^ Initial read on the full 192K file
>>   112819.766604: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=2 len=65536 pid=21806
>>                                      ^^^ Repair on the first 64K block
>>                                          Which would success
>>   112819.766760: __btrfs_submit_bio: r/i=5/257 fileoff=65536 mirror=2 len=65536 pid=21806
>>                                      ^^^ Repair on the second 64K block
>>                                          Which would fail
>>   112819.767625: __btrfs_submit_bio: r/i=5/257 fileoff=65536 mirror=3 len=65536 pid=21806
>>                                      ^^^ Repair on the third 64K block
>>                                          Which would success
>>   112819.770999: end_bio_extent_readpage: read finished, r/i=5/257 fileoff=0 len=196608 mirror=1 status=0
>>                                           ^^^ The repair succeeded, the
>>                                               full 192K read finished.
>>
>>   112819.864851: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=3 len=196608 pid=33665
>>   112819.874854: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=1 len=65536 pid=31369
>>   112819.875029: __btrfs_submit_bio: r/i=5/257 fileoff=131072 mirror=1 len=65536 pid=31369
>>   112819.876926: end_bio_extent_readpage: read finished, r/i=5/257 fileoff=0 len=196608 mirror=3 status=0
>>
>> But above read only happen for mirror 1 and mirror 3, mirror 2 is not
>> involved.
>> This means by somehow, the read on mirror 2 didn't happen, mostly
>> due to something wrong during the drop_caches call.
>>
>> It may be an async operation or some hardware specific behavior.
>>
>> On the other hand, for test cases doing the same operation but utilizing
>> direct IO, aka btrfs/267, it never fails as we never populate the page
>> cache thus would always read from the disk.
>>
>> [WORKAROUND]
>> The root cause is in the "echo 3 > drop_caches", which I'm still
>> debugging.
>>
>> But at the same time, we can workaround the problem by forcing a
>> cycle mount of scratch device, inside _btrfs_buffered_read_on_mirror().
>>
>> By this we can ensure all page caches are dropped no matter if
>> drop_caches is working correctly.
>>
>> With this patch, I no longer hit the failure on aarch64 with 64K page
>> size anymore, while before this the test case would always fail during a
>> -I 10 run.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> RFC:
>> The root cause is still inside that "echo 3 > drop_caches", but I don't
>> have any better solution if such fundamental debug function is not
>> working as expected.
>>
>> Thus this is only a workaround, before I can pin down the root cause of
>> that drop_cache hiccup.
>> ---
>>   common/btrfs | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 344509ce..1d522c33 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -599,6 +599,11 @@ _btrfs_buffered_read_on_mirror()
>>          local size=$5
>>
>>          echo 3 > /proc/sys/vm/drop_caches
>> +       # Above drop_caches doesn't seem to drop every pages on aarch64 with
>> +       # 64K page size.
>> +       # So here as a workaround, cycle mount the SCRATCH_MNT to ensure
>> +       # the cache are dropped.
>> +       _scratch_cycle_mount
> 
> Btw, I'm getting some tests failing because of this change.
> 
> For e.g.:
> 
> ./check btrfs/143
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc6-btrfs-next-134+ #1 SMP
> PREEMPT_DYNAMIC Thu Jun 15 11:59:28 WEST 2023
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/143 6s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
>      --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
> 2023-06-19 17:04:00.575033899 +0100
>      @@ -1,37 +1,6 @@
>       QA output created by 143
>       wrote 131072/131072 bytes
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
> the entire diff)
> Ran: btrfs/143
> Failures: btrfs/143
> Failed 1 of 1 tests
> 
> The problem is this test is using dm-rust, and _scratch_cycle_mount()
> doesn't work in that case.
> It should be _unmount_dust() followed by_mount_dust() for this particular case.

Any idea on a better solution?

My current idea is to grab the mounted device of SCRATCH_MNT, then 
unmount and mount the grabbed device, instead of always using scratch 
device.

But it may look a little over-complicated and would affect too many test 
cases.

Or maybe we can detect if it's using dust device inside 
_btrfs_buffered_read_on_mirror() instead?

Thanks,
Qu
> 
> 
>>          while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
>>                  exec $XFS_IO_PROG \
>>                          -c "pread -b $size $offset $size" $file) ]]; do
>> --
>> 2.39.1
>>
