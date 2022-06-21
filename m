Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4910B552C9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiFUIHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbiFUIHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 04:07:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FB2496F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 01:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwnQHzLAoD+e3qlWYDuPSBvgcDbQRn8xGNeflHzcfa3j9BLJSzrGM4oNhWz9LCbyY/Tl7l+fo+XQ/RBHnJHXQAHeSiq730BTQFnfJO8Fdh+0kN1BHJdnkVlF0UVncup0fwJlErn/QSeJmPc7GFDUUWBU2s8+Zt2LImAvshUIJ2DxLbx3ndueO6UZip9bcQ4A2X1Ve+OKIbcSMiKFklfOYsJElDM6bx/+L+p++0YOga0gv2ap4Afq3YXQRRHfFJBtHdvYpw/4AgKqV5X2JhtK+/LsNolpwhnfjpJFDPXpit4C33896zXzioMrcjK8A1GrdklTtxHniZFH7wArfSGXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UszVzIFGEsTd1Ts7Lb+f7DJMIqwxAt9U7HmeDiRsY6k=;
 b=VbdGvEBZwAlikQMXf1xobj3ISFYG9mvE9ZekJQuzu9ZeKT7boKDSf91iIvNEOAmaRBDoYGZvIKr85O7h/4i10SBint1qZxqUa/VANaMvX29CLN5fYMXrCO5f801PLOZOnM8+ZwQ6iINgijrkG49GBFlh5SLnJwCzL8afdd3FgAIRc8g3A1F+u2gd10qqGF3teJFl7v9je5HH8ysjn/tNYxy7yXNf6Lk+INMdirG8RIfjkCJfGkfpMyvkcOqZZTiT47sYBudmT936IgHNDv7+rxfrYi9jxBADvziDinWJxblpRU3icTSUlubQFIv9BBfeaYQahexzRwusQ38+9aC9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UszVzIFGEsTd1Ts7Lb+f7DJMIqwxAt9U7HmeDiRsY6k=;
 b=cBqFfUovOnasOuJt2gyuj7HX55LG1DVRh/Zx4Zvn1+IepbSV38V59ZBqXzXvbZCozg/ogdQfXtcpEsweTg7tXnuHMRiiRoDbeK3yLM6oqC9S13W8LZDCYeSpmSWnnj6DIB/OqyDQ1SeF2j6jOEWVzlJ9SK/ctBeW2zY3Q/qrJqqKQOl8w+wAH2Yo+/sOE8UfkuL09+C60Gp4vX4HKZzWOVu3UOkBDYaIXi1dRb//RxjmEspK+2JtdXVCuFu5wsnx9JnlxCDo8vFymUk1ENLj26u7Ac5R6P+GCDOoifVhQBjWIdM5He9PuZRZYkQVx98zvQI8FgBb9marVaLoi6pBQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 08:06:59 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 08:06:59 +0000
Message-ID: <875d9f74-04bd-3e42-e177-b80d4da1902c@suse.com>
Date:   Tue, 21 Jun 2022 16:06:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
In-Reply-To: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:301:4b::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8c29d1-f07c-43af-1519-08da535d03f2
X-MS-TrafficTypeDiagnostic: DBAPR04MB7240:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7240A32ADCF85C72F4184E25D6B39@DBAPR04MB7240.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4leYqZ20zfd5r/J8XeWEhs4BQfrVTQEv5AyCmVLPrlUYW+ksMdU2EBsl9Rg58iop3BzM4nMpMzHCOvuMTh8hmbWKdgx3H8K1q0PGdwu08FutMlrqLXn0TQ+7S+at7tB1O4KIlvc9r+lwaqu/saXiJRqJyyxgTaZs4Nc8JkmRxFnb7SLsBMi5fvRt7NEm/N8kGJJTzCZL71pKNwTNR1I1TXoemNyEx03I/syvkNr4wNRY9IiE7XVpRv5Ws86/HjNO8hhlm0wNSIukAlxm3YEuVp7dQhKMM37o9FiiqvJAK+JUKNujk4Di6QRoQuo1lM8ogmHgyo7Pz6ALXa3b78GkjhtA9dSDejQxjjxGoZBnDlbsSBkEiasvTEDPj7P30mKJ4zICB2L5y4WpqjkJmWU6fRzmt6lnltK2r98NDg/5rnboLi1toAYfbDsWzefwrpCm2fZs/Fl2gmU1x4Togu3qtxQOV0QHWHcQhELJE1FD992wSxE2dScKvenGkSvYyPRyFEIWnl1IvYvKlvQPKgl4e0xfvkeTlnUWScIhuCyCjRlPUxFY0kdhVzfWyF4r8aXWK8TH1WIw08cQ+GTCYLzs4q/nZeqbha+P322aSTe7jWgKX2zJ1fHRJ1dm9GWjE9osHuP86zRUoe0u04fYuYCD6c+4T/eaLcgkdNep8Dci5D8EFluWA6mjgl3pHY+XxqF0slczr1nhnrWXyn0oQWW+IOikZ47H5nyoSBSgcndLShMX9zUnUXChd3RssGS5p04
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(366004)(136003)(346002)(53546011)(6666004)(186003)(6506007)(41300700001)(38100700002)(2616005)(86362001)(31696002)(6512007)(36756003)(83380400001)(4326008)(30864003)(66556008)(66946007)(8676002)(6486002)(54906003)(31686004)(478600001)(5660300002)(6916009)(2906002)(66476007)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFRRVJTaWNrejJyVGd6Ri9CaGlhb2VnUDE3RlNkRjR3MEs3ZzRRQmJmUTM1?=
 =?utf-8?B?UFVxNDN4VnRXWDBRNCtFV1VNaENCYnBtMXJ6a0dHNmNYak9lNUg4OGlPMFBI?=
 =?utf-8?B?V2d2V0kyOXNvdGZVeVpnYk5UZTZUSjh4c2hzTDlMdk5IcVFsblVpczJQQlg4?=
 =?utf-8?B?b0RXUzlPNEZsZEM3TWo0NTJsaG1ieGlCcXkycE04dDY1NkpFY2ZORjJ2aVJG?=
 =?utf-8?B?OTVRUlY4amtDZEg0THUwMjlFSEdWYlNRZzlScGhub2tNaUpuVkhWbXpMYzVD?=
 =?utf-8?B?TjBTWTAxZytFMngwMzRiOTRDVDdhZXV1NkwwMUh0d3Iwd1dhWUFLZDVvWGVI?=
 =?utf-8?B?c2JiSVJxcW0wWDJjVjVSMkkxK3ZnZ1ZObFMrcnRsUTU2VThWRzN5SVZrdFFS?=
 =?utf-8?B?V2daMGRBNENxbWhyRHZnZEFhRVlKRnFtaS9NejMveXJQRXl6VUl4WUZGcmRj?=
 =?utf-8?B?a3RNWm9PUm1IZHRLTEsxejhkRDFwbXlLbnJJR3VwZC9LQ3lFNmZKK29vMCs0?=
 =?utf-8?B?N0s5KzIxMjJhb0V6S0IxMUhhalo4R0k1QWFBZWFYcjVvZUVFclZLWWxtTTNs?=
 =?utf-8?B?NzdtbThyR1JrbDB2d2c3Vlh6Uk01NW1iWTVnem1WcHdUODlIRkw4d0tyeHFw?=
 =?utf-8?B?SmRMTkFXcW1VQTYxZDFoVjlMVEpTWFR2MWJRTkIwbW1yWXZoQWNqbG5BOXJ0?=
 =?utf-8?B?SWlpWk5KalpEaHp0c0d4Z2x0TFpRbXNZMUlDL2NPbCt6OXpoN1gveTNtUDVS?=
 =?utf-8?B?ZXZUN3ZTK2NpSU15RmNrL0Z5bDVqVWxEZFl2RjBJYVBIQmlxTzZEVG5XSkpL?=
 =?utf-8?B?TElTV0htMDNyc1ZWcnc3U0JkeTFjL3IzdWN0QjdWODF6TDBYaElSNW9KVzFa?=
 =?utf-8?B?WjVzN2dPQ3h1dlI0MUhoWUtrYWE4YndGcDdtNHZ1ZFk5Nng4RU9TWjVqQ3U1?=
 =?utf-8?B?MGM0bysxaXd4dVJnRmxYSTlMeTZqZlBkNHduZHdPTVJEeXVuTCs4VEZ2eVdq?=
 =?utf-8?B?U2o4STBjQVFlNjFFVHFSM3ROV2lSbXlvMnJxMy8rakgyYXRSOEZoMURMbjBl?=
 =?utf-8?B?cXVlNmZRQlI1d3JPejJMaUg5eE5EcTlqNEloSWk5OW1ncEhncDJKN3ZESjF2?=
 =?utf-8?B?cnc1V0hhSC9IL0NZcWtqd1pnQ1BTdmVRL1YveENRNHo4OHhMdlMzcVJzS05y?=
 =?utf-8?B?MzNsYlFhZlNMZE1GNldSS1dxZXFXb3J2Rk9qSUdDQU16TmdRdEY0WWcrSHdN?=
 =?utf-8?B?SStEL0hHYmVoMTFzamJzUDNQVVFnRGdiOGRudmxDVEJabjhXQlk4eUJKbWh1?=
 =?utf-8?B?Z2cyZis0SGt5cWVRK3hyNm5WMldqOTcwK013Q1BUQ1J6WnA4QUF4Uy9kT3VF?=
 =?utf-8?B?UG10aUJ0TUNUb1pITmZybG15M01jTnVSYWlhS0l5MTh1bWRILzF1eEIyVHRR?=
 =?utf-8?B?SEthdHJ1SUszWUF1WC9BL0Qvams0bmhVanUvWVdBN3pvbkNRU1I5RmdBODc2?=
 =?utf-8?B?Q0hOQVJpcnZOVkhIYU1aUWxsTXhSdXJaWVZPT2d5cGlSMUVkNkMzUHgwSldl?=
 =?utf-8?B?NHhvUXlWdGVnMUNHT2NhRzdORitTRUtaZC9JanUyWG83eHd5a2VUeWhDQ21r?=
 =?utf-8?B?Q3F0M0NGdXN5SFdpMk5oRDlNQStWaFlHaVZ6UWJaaUhJaWovRWZKZVlIaHdW?=
 =?utf-8?B?clpEeTk5SGJ0ckxSLzdxNWVyTFNBQ1A0b2p3dzcwZ3NWNFg2empDTUNudFlN?=
 =?utf-8?B?OVo3WnJOZjRxVEVwS3l4Slg0dUZCcjZFL3NKb0lJMjVTMFVqaDh3NVlNb2ZK?=
 =?utf-8?B?bWRVV3J6MklJOHpiMTdQRS8ycUI1SEtkZk5oMWtiQktXR0xZT1h4T3VlUlRJ?=
 =?utf-8?B?bDJkY0NmUlYyMUdrMUxNS1QwMnhnOTN1emZFbU55TndoQ0UrZWRBNDlWcG9W?=
 =?utf-8?B?eEIrNnRrSU9lUzRBQThCOFRiVkIxQ3poaVB2RnFnUC9RblBZSDUxbk1mRnNz?=
 =?utf-8?B?OEJKYXRsM0h3dWU3NGpiZG5aNnRSdmZLeWV4NXl1ZWtCbWZ3MDFBQlZ0TzVR?=
 =?utf-8?B?UFRscXI3ZXZseUdHYWcybjBFY0RlSmZvemJ0WTRTQktiV0dweWI0dGNGWlZS?=
 =?utf-8?B?SHFyU3Z0U01hMmlLSWZKYVJWZUt0dGlXSmNvaXVhWXY4WUhmQ1BOaGc4aWwy?=
 =?utf-8?B?ZnZvZ2s2UFFZc3MwNVJJUTgyZ3cvMkkvZk96Q1F1THkvc3crSFhTK1ppenVF?=
 =?utf-8?B?N0tib2xPQnRnYzNWV1JSTXkvTW1GcHc3SU9ZQ0g1UHlaK3RPU21EeFRGYVBu?=
 =?utf-8?B?WUFhd1NIYUFSTzcxT3NOL2dMVkoveTJjV3psOTVjMzlqaHdZaVlubzQ1Rm02?=
 =?utf-8?Q?nDF9hlxv3DNTpgCTdkywdZR2OxaDW0InFmVDQQv3xs0G8?=
X-MS-Exchange-AntiSpam-MessageData-1: m82Qt1ICZLzD1w==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8c29d1-f07c-43af-1519-08da535d03f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 08:06:59.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUXJzFJkpAlUCZx5EhFg7OiaKcbEYstlfHogVfl1vSpy8B+sV05lMQmtfCNqaK8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 13:59, Qu Wenruo wrote:
> Inspired by recent kmap() change from Fabio M. De Francesco.
> 
> There are some weird behavior in zlib_compress_pages(), mostly around how
> we prepare the input and output buffers.
> 
> [BEFORE]
> - We hold a page mapped for a long time
>    This is making it much harder to convert kmap() to kmap_local_page(),
>    as such long mapped page can lead to nested mapped page.
> 
> - Different paths in the name of "optimization"
>    When we ran out of input buffer, we will grab the new input with two
>    different paths:
> 
>    * If there are more than one pages left, we copy the content into the
>      input buffer.
>      This behavior is introduced mostly for S390, as that arch needs
>      multiple pages as input buffer for hardware decompression.
> 
>    * If there is only one page left, we use that page from page cache
>      directly without copying the content.
> 
>    This is making page map/unmap much harder, especially due the latter
>    case.
> 
> - Input and output pages can be unmapped at different timing
>    This make it almost impossible to convert the kmap() into
>    kmap_local_page().
> 
>    As kmap_local_page() have strict requirement on the sequence of nested
>    kmap:
>                     OK              |            BAD
>    ---------------------------------+---------------------------------
>    in = kmap_local_page(in_page);   | in = kmap_local_page(in_page);
>    out = kmap_local_page(out_page); | out = kmap_local_page(out_page);
>    kunmap(out);                     | kunmap(in);
>    kunmap(in);                      | kunmap(out);
> 
> [AFTER]
> This patch will change the behavior by introducing 4 helpers (in two
> pairs), to fulfill the requirement on the kmap_local_page():
> 
> - map_input_buffer() and unmap_input_buffer()
> 
>    For map_input_buffer(), there are 4 different combinations:
> 
>    * avail_in > 0 and use workspace->buf
>      Do nothing, we can still use the existing @avail_in and @next_in.
> 
>    * avail_in > 0 and not use workspace->buf
>      Use @total_in to grab the next page, and re-setup @avail_in and
>      @next_in.
>      (The common path)
> 
>    * avail_in == 0 and we have at most one page left
>      Use @total_in to grab the next page, and re-setup @avail_in and
>      @next_in.
>      (The common path)
> 
>    * avail_in == 0 and we have multiple pages left (S390 optimization)
>      Copy the pages into workspace->buf, and use workspace->buf.
> 
>    For unmap_input_buffer(), we just unset workspace->in_addr and
>    workspace->in_page.
> 
> - map_output_buffer() and unmap_output_buffer()
> 
>    For output buffer, we always using single mapped page, so for
>    map_output_buffer() it's just using @total_out to grab the page, and do
>    page allocation if needed.
> 
> Then in zlib_compress_pages() we always map input buffer first, then map
> output buffer, finally call zlib_deflate().
> 
> And after zlib_deflate() we immediately unmap output buffer, then unmap
> input buffer.
> 
> By this, we at most nest once (both input and output are using mapped
> page), and the nested order is always fixed.
> 
> Furthermore, we avoid extra memcpy() for non-S390 cases.
> 
> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Still only tested on x86_64, although I'm already building a dedicated
> VM for 32bit tests, it may take some time to build the environment.

Good news, after tons of caveats related to i686 and my choice of 
distro, I finally setup my i686 VM and tests ran fine here.

> 
> This time, since S390 is having its own special handling, tests on
> S390 would also be appreciated.

So the remaining untested path is only S390 now.

Thanks,
Qu

> 
> Changelog:
> v2:
> - To avoid unnecessary memcpy(), always map and unmap input/output
>    buffer around zlib_deflate().
> 
>    This is to meet the requirement of kmap_local_page() and
>    kunmap_local().
> ---
>   fs/btrfs/zlib.c | 262 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 160 insertions(+), 102 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 767a0c6c9694..c42b5b5e7535 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -19,16 +19,25 @@
>   #include <linux/bio.h>
>   #include <linux/refcount.h>
>   #include "compression.h"
> +/* For ASSERT(). */
> +#include "ctree.h"
>   
>   /* workspace buffer size for s390 zlib hardware support */
>   #define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
>   
>   struct workspace {
>   	z_stream strm;
> +
> +	struct page *in_page;
> +	struct page *out_page;
> +	void *in_addr;
> +	void *out_addr;
> +
>   	char *buf;
>   	unsigned int buf_size;
>   	struct list_head list;
>   	int level;
> +	bool using_buf;
>   };
>   
>   static struct workspace_manager wsm;
> @@ -91,20 +100,140 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>   	return ERR_PTR(-ENOMEM);
>   }
>   
> +/* Either map a page (non-S390 path), or prepare workspace->buf (S390). */
> +static void map_input_buffer(struct workspace *workspace,
> +			     struct address_space *mapping,
> +			     unsigned long total_in,
> +			     u64 orig_file_offset)
> +{
> +	const unsigned long bytes_left = total_in - workspace->strm.total_in;
> +	const unsigned int in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +					      workspace->buf_size / PAGE_SIZE);
> +	struct page *in_page;
> +	u64 file_offset = orig_file_offset + workspace->strm.total_in;
> +
> +	/*
> +	 * We still have some bytes left in the input, rebuild the original
> +	 * input context.
> +	 */
> +	if (workspace->strm.avail_in > 0) {
> +		/*
> +		 * We're using the S390 specific input buffer space, just do
> +		 * basic sanity check and exit.
> +		 */
> +		if (workspace->using_buf) {
> +			ASSERT(workspace->strm.next_in -
> +			       (unsigned char *)workspace->buf <
> +			       workspace->buf_size);
> +			return;
> +		}
> +
> +		/*
> +		 * Other wise, we need to map the page, and set @next_in
> +		 * into the mapped page address.
> +		 * The common path can handle such case without problem.
> +		 */
> +		goto common;
> +	}
> +
> +	/* Re-fill the input buffer for S390 path. */
> +	if (in_buf_pages > 1) {
> +		int i;
> +
> +		workspace->using_buf = true;
> +
> +		for (i = 0; i < in_buf_pages; i++) {
> +			in_page = find_get_page(mapping,
> +					(file_offset >> PAGE_SHIFT) + i);
> +			memcpy_from_page(workspace->buf, in_page, 0, PAGE_SIZE);
> +			put_page(in_page);
> +		}
> +		workspace->strm.next_in = workspace->buf;
> +		workspace->strm.avail_in = min_t(unsigned long, bytes_left,
> +						 workspace->buf_size);
> +		return;
> +	}
> +
> +common:
> +	/*
> +	 * The common case for non-S390 cases to map and set @next_in
> +	 * and @next_avail.
> +	 */
> +	workspace->using_buf = false;
> +
> +	in_page = find_get_page(mapping, file_offset >> PAGE_SHIFT);
> +	ASSERT(in_page);
> +
> +	/* Page unmap and put will happen in unmap_input_buffer(). */
> +	workspace->in_page = in_page;
> +	workspace->in_addr = kmap_local_page(in_page);
> +	workspace->strm.next_in = workspace->in_addr +
> +				  offset_in_page(file_offset);
> +	workspace->strm.avail_in = min_t(unsigned long, bytes_left,
> +					 workspace->buf_size);
> +}
> +
> +static void unmap_input_buffer(struct workspace *workspace)
> +{
> +	/* If we're using buffer, no need to do anything. */
> +	if (workspace->using_buf) {
> +		ASSERT(workspace->in_addr == NULL &&
> +		       workspace->in_page == NULL);
> +		return;
> +	}
> +	/* Otherwise, just unmap @in_addr and put @in_page. */
> +	ASSERT(workspace->in_addr && workspace->in_page);
> +	kunmap_local(workspace->in_addr);
> +	put_page(workspace->in_page);
> +	workspace->in_addr = NULL;
> +	workspace->in_page = NULL;
> +}
> +
> +static int map_output_buffer(struct workspace *workspace,
> +			     struct page **out_pages, int *nr_pages,
> +			     int max_nr_pages)
> +{
> +	/* Our total output is already reaching the max amount of pages. */
> +	if (workspace->strm.total_out >> PAGE_SHIFT >= max_nr_pages)
> +		return -E2BIG;
> +
> +	/* Allocate a new out page for the array. */
> +	if (workspace->strm.total_out >> PAGE_SHIFT >= *nr_pages) {
> +		ASSERT(workspace->strm.total_out >> PAGE_SHIFT == *nr_pages);
> +		out_pages[*nr_pages] = alloc_page(GFP_NOFS);
> +		if (out_pages[*nr_pages] == NULL)
> +			return -ENOMEM;
> +		(*nr_pages)++;
> +	}
> +
> +	/* Setup @next_out and @avail_out using the page. */
> +	workspace->out_page = out_pages[workspace->strm.total_out >> PAGE_SHIFT];
> +	workspace->out_addr = kmap_local_page(workspace->out_page);
> +	workspace->strm.next_out = workspace->out_addr +
> +				   offset_in_page(workspace->strm.total_out);
> +	workspace->strm.avail_out = PAGE_SIZE -
> +				    offset_in_page(workspace->strm.total_out);
> +	/* Page unmap will happen at unmap_output_buffer(). */
> +	return 0;
> +}
> +
> +static void unmap_output_buffer(struct workspace *workspace)
> +{
> +	if (workspace->out_addr)
> +		kunmap_local(workspace->out_addr);
> +	/* Unlike input buffer, we just unmap the page, without putting it. */
> +	workspace->out_addr = NULL;
> +	workspace->out_page = NULL;
> +}
> +
>   int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   		u64 start, struct page **pages, unsigned long *out_pages,
>   		unsigned long *total_in, unsigned long *total_out)
>   {
>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
>   	int ret;
> -	char *data_in;
> -	char *cpage_out;
>   	int nr_pages = 0;
> -	struct page *in_page = NULL;
> -	struct page *out_page = NULL;
> -	unsigned long bytes_left;
> -	unsigned int in_buf_pages;
> -	unsigned long len = *total_out;
> +	const unsigned long len = *total_out;
>   	unsigned long nr_dest_pages = *out_pages;
>   	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>   
> @@ -121,59 +250,23 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	workspace->strm.total_in = 0;
>   	workspace->strm.total_out = 0;
>   
> -	out_page = alloc_page(GFP_NOFS);
> -	if (out_page == NULL) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -	cpage_out = kmap(out_page);
> -	pages[0] = out_page;
> -	nr_pages = 1;
> -
> -	workspace->strm.next_in = workspace->buf;
> +	workspace->strm.next_in = NULL;
>   	workspace->strm.avail_in = 0;
> -	workspace->strm.next_out = cpage_out;
> -	workspace->strm.avail_out = PAGE_SIZE;
> +	workspace->strm.next_out = NULL;
> +	workspace->strm.avail_out = 0;
> +	workspace->using_buf = false;
>   
>   	while (workspace->strm.total_in < len) {
>   		/*
> -		 * Get next input pages and copy the contents to
> -		 * the workspace buffer if required.
> +		 * Always map the input before output, this is required by the
> +		 * nested kmap_local_page().
>   		 */
> -		if (workspace->strm.avail_in == 0) {
> -			bytes_left = len - workspace->strm.total_in;
> -			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> -					   workspace->buf_size / PAGE_SIZE);
> -			if (in_buf_pages > 1) {
> -				int i;
> -
> -				for (i = 0; i < in_buf_pages; i++) {
> -					if (in_page) {
> -						kunmap(in_page);
> -						put_page(in_page);
> -					}
> -					in_page = find_get_page(mapping,
> -								start >> PAGE_SHIFT);
> -					data_in = kmap(in_page);
> -					memcpy(workspace->buf + i * PAGE_SIZE,
> -					       data_in, PAGE_SIZE);
> -					start += PAGE_SIZE;
> -				}
> -				workspace->strm.next_in = workspace->buf;
> -			} else {
> -				if (in_page) {
> -					kunmap(in_page);
> -					put_page(in_page);
> -				}
> -				in_page = find_get_page(mapping,
> -							start >> PAGE_SHIFT);
> -				data_in = kmap(in_page);
> -				start += PAGE_SIZE;
> -				workspace->strm.next_in = data_in;
> -			}
> -			workspace->strm.avail_in = min(bytes_left,
> -						       (unsigned long) workspace->buf_size);
> -		}
> +		map_input_buffer(workspace, mapping, len, start);
> +
> +		ret = map_output_buffer(workspace, pages, &nr_pages,
> +					nr_dest_pages);
> +		if (ret < 0)
> +			goto out;
>   
>   		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>   		if (ret != Z_OK) {
> @@ -184,6 +277,10 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   			goto out;
>   		}
>   
> +		/* Always unmap the output before input. */
> +		unmap_output_buffer(workspace);
> +		unmap_input_buffer(workspace);
> +
>   		/* we're making it bigger, give up */
>   		if (workspace->strm.total_in > 8192 &&
>   		    workspace->strm.total_in <
> @@ -191,28 +288,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   			ret = -E2BIG;
>   			goto out;
>   		}
> -		/* we need another page for writing out.  Test this
> -		 * before the total_in so we will pull in a new page for
> -		 * the stream end if required
> -		 */
> -		if (workspace->strm.avail_out == 0) {
> -			kunmap(out_page);
> -			if (nr_pages == nr_dest_pages) {
> -				out_page = NULL;
> -				ret = -E2BIG;
> -				goto out;
> -			}
> -			out_page = alloc_page(GFP_NOFS);
> -			if (out_page == NULL) {
> -				ret = -ENOMEM;
> -				goto out;
> -			}
> -			cpage_out = kmap(out_page);
> -			pages[nr_pages] = out_page;
> -			nr_pages++;
> -			workspace->strm.avail_out = PAGE_SIZE;
> -			workspace->strm.next_out = cpage_out;
> -		}
>   		/* we're all done */
>   		if (workspace->strm.total_in >= len)
>   			break;
> @@ -225,31 +300,21 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	 * space but no more input data, until it returns with Z_STREAM_END.
>   	 */
>   	while (ret != Z_STREAM_END) {
> +		ret = map_output_buffer(workspace, pages, &nr_pages,
> +					nr_dest_pages);
> +		if (ret < 0)
> +			goto out;
> +
>   		ret = zlib_deflate(&workspace->strm, Z_FINISH);
> +
> +		unmap_output_buffer(workspace);
> +
>   		if (ret == Z_STREAM_END)
>   			break;
>   		if (ret != Z_OK && ret != Z_BUF_ERROR) {
>   			zlib_deflateEnd(&workspace->strm);
>   			ret = -EIO;
>   			goto out;
> -		} else if (workspace->strm.avail_out == 0) {
> -			/* get another page for the stream end */
> -			kunmap(out_page);
> -			if (nr_pages == nr_dest_pages) {
> -				out_page = NULL;
> -				ret = -E2BIG;
> -				goto out;
> -			}
> -			out_page = alloc_page(GFP_NOFS);
> -			if (out_page == NULL) {
> -				ret = -ENOMEM;
> -				goto out;
> -			}
> -			cpage_out = kmap(out_page);
> -			pages[nr_pages] = out_page;
> -			nr_pages++;
> -			workspace->strm.avail_out = PAGE_SIZE;
> -			workspace->strm.next_out = cpage_out;
>   		}
>   	}
>   	zlib_deflateEnd(&workspace->strm);
> @@ -264,13 +329,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	*total_in = workspace->strm.total_in;
>   out:
>   	*out_pages = nr_pages;
> -	if (out_page)
> -		kunmap(out_page);
> -
> -	if (in_page) {
> -		kunmap(in_page);
> -		put_page(in_page);
> -	}
>   	return ret;
>   }
>   
