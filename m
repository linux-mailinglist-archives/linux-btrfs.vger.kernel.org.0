Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97653631745
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 00:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKTXB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 18:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTXBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 18:01:25 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090E2AE3C
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 15:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqR829piv4dZsN0birk/kImP55TAveeMTDxa+d9ei0IIvBgY/+WmjPzZbFclAZy8jSDBSTkK/5qqdvAKpSza1WJutHvhkv/Uo/Z8QrzzGQovCeqia/Ct8CtM1CwuoBslixDKYfNzVQS/QAX+jc/dCoNnjBUfVTxLjTtm+KPeAsoSwrdqiQ/74xcPVtXblQCkdzAJyGEVmsNocoNnrmMm1khPH7Rq7N1IqV52iqlamaEXz7r6ymRYv0PXlDLPC//2nw5xk4rQTqyNQkRD7UzbkM7rGKAIjRBgLl8Ke3d2kbD25Dv+Cz3B/3F0tzq6eU6HSGZqy0gx5WQe9X0W+++HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YepqWcTUjwCzbgaK+4WBfPg9sue0lbVdbZcp1HE4L0A=;
 b=AoMvQnu9+fO9ndlrvfXOdk3wNb4Y585PubeG7xNCe7cxIuzylbz005i8NsrOBY6OulaJGazYg7NYzYHtNxaY7dKNZvo0JzViFdObh8G7biLwjm1PKkU9CG9QIA6KSQnDkzrNELG3tw2yUsf72hyh4BQO0QwPk//5jbgm9FjIP9fWKfqk8XnsAHQFugsvPtyUgouwXIKiTnn5svjfRXIhTZ98U+az5AKZwqDc/ZsargNwFs4hsLTj6W9KH+4+ttkd7LcF+MF35h2k7k14yOVWyYFFz0hRRFh9h0Bx9XjuagjNyZaKoS0lDa9J4ukk1/prc0vqSxbXfoC1VjqIJY8efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YepqWcTUjwCzbgaK+4WBfPg9sue0lbVdbZcp1HE4L0A=;
 b=R2SZUrLaWaFJxRxJmy75I+/Lb7e799Q3S0sw4gxTLWbN7vfjhmfC6f4nDPgdcMIhO6mY2u3hG//ly6t2w5zmfXDFd62c7SnrfmW5VoTm3rF5ucymeuLIvyTipBRJQ9fPzgT35NMQHOg3Dz81UDPiOHyrwsHQ8S3GEzupUkM7QCrbF5YV9EtXjbQHM6G/EUK1Muo/xG+f+Mt1lRoxXIG0cBnx8ck06rIrtdQsJoW6TfphdYCGzFL1R2PuGcw7EkW10Dp1dUI/qJx2b1XzJIrIHU0TSJCRU3Q8Vh6oeRZVE4fX2zrkasUOH620a7gKesyjJWxPa0si4kN5F5yPLzAX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9270.eurprd04.prod.outlook.com (2603:10a6:102:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Sun, 20 Nov
 2022 23:01:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 23:01:19 +0000
Message-ID: <ad10e921-9155-4741-e0ab-e0cc4a66f27c@suse.com>
Date:   Mon, 21 Nov 2022 07:01:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: block group x has wrong amount of free space
To:     Hendrik Friedel <hendrik@friedels.name>,
        Paul Jones <paul@pauljones.id.au>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
 <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <em53860311-b978-4908-abfd-24b5acca9c5a@7b52163e.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbee90d-4b23-4c3c-c72c-08dacb4b21e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEle+3Akz7GE5ecpYNJ9Db+LReWtbsYc9f5XoLtjYTTpTjI5bXugkiTRTszqE2uAx4B+EWs/5kTYZXR3oFkLMpEyLY+48jljGZFPenDJ37HAvoDwOZt+ok2sc20LXCT7tGqIIaXmGE9O9CjFyGyTTtbt3f2mcgG+b6pOufcvWGaAEGx8ghH1ha3scx66j1qDNzN4BChqhw0dawcEynTFN5Tr7PJM7JFJ4jmfpdUgseJjqySQvaI7LExJheHNosN8rvEUf9gjyJSsktdQ8A1NMj45poAeT1D5XbPMvnj7Za3J43HUD8eAgX0Mq11DBA9mNswV7CJ7D2GQ/Am+RtJGsLihG3d4Sd30iQIxVcgpf8PRRRyyKo+CaEWOtX8GeMeM0PDyF0uG5OXGcbXOVjyETwyOgVnyfePDQLwZDOsmJ8vaxOtS1ZeQL2rQegUnVPA7CWH8p+xowj4s8OJz9SYOhkyHMl/ZIaArNCa2x/JtvwllI7P6hIfG0LbbohtyFOtYpu58jqWQaQe0aoflNo6Peo3TZqCIVYE7Hs+l25/zserj6dqSQsgDBZRA2GrKcj+3zZjz+WWqGsmP5EZirK2nEVhTPRqm+NTtjfCaFjCamCxPX0QcGrUkWHF22T/o6tcQ4NNfyotY8p4piJFNRyPARx2cJDzbnmACOlTWtSa4TymG29sHUKj3i/GX5XDs7muAasrqhcsZlXDlF/mvKacn7qqArTj2xkmRPyrhsyeDwKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39850400004)(376002)(136003)(366004)(451199015)(53546011)(6512007)(2616005)(83380400001)(38100700002)(186003)(4744005)(5660300002)(2906002)(110136005)(6486002)(478600001)(66946007)(8676002)(6506007)(6666004)(41300700001)(8936002)(316002)(66556008)(66476007)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlmdXgrTGdZZkc5L1p4RzE2WXBWaHV2OEN1czM2NmJhRnlRVTlzVXRFOG10?=
 =?utf-8?B?d2FSdFp4L2pZam5uK0wxSHFqS2JFMmFKZnVpWEYyK2FwNFJOTjVWV0s0LzBh?=
 =?utf-8?B?eEVwUEV5NXF5N3M3QVMzZkFXRVlPUER6dllqa2JUQlBicUcxZkJOUDRHUVUr?=
 =?utf-8?B?cEt4MGI5cG9xOVE5S0VoQzRrWHBmYXpIMHpJcFp3L2VUTzlVMU5xQXFSbHdo?=
 =?utf-8?B?dmdjSTNrRkpkT1VjdXA4bkNCUFdEUlpsbGxvNzQ5RzJwbzdRSnpxb0pNTWps?=
 =?utf-8?B?TU0vcEMzSnNNVnhaV2huMmtTb216Qm90Y3BIbUZwdXVubDVmUWtZR1dJNENk?=
 =?utf-8?B?S2FCbXMxWDlXODYyMEg4NUloMTR6T1hqNjlROGRHdVFXYi96endJNjBzdVVu?=
 =?utf-8?B?NVF0aFUwckJaQTNrL3hEL0RHUFRoam92ekpHVEtTVm9pYnNhUHRxMUZHNGtr?=
 =?utf-8?B?MllFeFdzaFMrd3Q4UklSNXNPV2xMSm11aEE3eEx2WmVNZ0t5ZUxYTkJtTWRR?=
 =?utf-8?B?QVNmMHE2WGRhUTd6dHJ5a2xyR1VkQnpaN3hkUzlMdGsrTkpZWkJReFRPblpV?=
 =?utf-8?B?dW5XQ3JIbVdBbk1TMUVnUmEzRlE5L0VmRm9vbndxZ0hBcmk0SFlldTRmdkNM?=
 =?utf-8?B?MXYvWThwZHhIcWREbFZvUFpXT2lZTkwxTU83b3lPcVFTQThRUjFsNUN5UWRi?=
 =?utf-8?B?c2tPNi8rVksrRHRCcWhOUzA1d0FDbkw3TUFhSnYxbjJOTllPT0hWVjErQzMr?=
 =?utf-8?B?VTB4QVJYblJLemVLb202aUJjQ2h6c1cwc2QzYXhqWndXSVJxSnRvK0U5SjVQ?=
 =?utf-8?B?VTZkQVlYcEZnSEQxRHROaEdUSi95a1hwaDduVTA1d295RGJVbXJRa1dFVHZq?=
 =?utf-8?B?aWFIVXREOEJGRFVCRjN5N2NVTzJDdVp5R2tobkJrcUoyVzRZS3BWczFPb0hF?=
 =?utf-8?B?Q2NwbGduSUJLcTFIN2hsWjBmRE5wOGN6N2JqTHdVNmFvMk12amlseXJMOCtv?=
 =?utf-8?B?U1hmdTExcnNxaVRiWGlrWDdmOUQ2OXJkVEFtRXhhVlJJN0Jwdy9pTGJiVnpW?=
 =?utf-8?B?UFlxR0tHY1VndXJ2S01MOFlWMDhBWnkyUyt0bDVvWXpMS3ZWTlMxRGNvaWc4?=
 =?utf-8?B?ajJQckV0S3lyMGpJZmdVVmliZlZmOEQwUnVrNTdpczdEa0J2dEdLTUJGNXhE?=
 =?utf-8?B?bmdNeE8xR1VBV0xaQkYxYWpESEN2dFRRNVFhWkhOUVdCQlRpUDFFS1pINUd4?=
 =?utf-8?B?VC9SNHJBTmFoa0RRV04wTmhzMUk2dG9EcHllSmVWZzZhaGQ0d1ptVElJSURI?=
 =?utf-8?B?bUVTTmp4NnF2c0xNenRxN0V6VWRJUWRHSkNKanlyd3hNUmFsdittL0xwYis0?=
 =?utf-8?B?REhYbUF4eThxekgxdW83SjA4UWYyNWVsQ2h6RU9MZm1qNjVDeU5XemF4NFBt?=
 =?utf-8?B?UnV0Y3JNbTRQdXdlVjJQRE8ybVJ0THRXZjZCTm9BZWZnUEJ5YkVzcnhhd0lo?=
 =?utf-8?B?VlQydDVPQS8yWnhXUEZHdTJ6SFY1QjVPaHFJTE1sWXdPSFh1a01nellISXpq?=
 =?utf-8?B?R1d6OW92WWtRcmxMRXlaMEhFcThiQWExdWNrb1Vra3VFZlh5YWhZZXp1b1hL?=
 =?utf-8?B?U0dyRk52WUpGL3B0TVYrQ2dNRzAzQXNwTVJDOU9zOWpQWU02UnRNckhVcjZF?=
 =?utf-8?B?b3h5aG1SbDhFc3RiZzBjNlV3VHVPVUpackhtbkFVZ1pRTmY2UFBtNm96OWJ1?=
 =?utf-8?B?UUZ6YXZYdWU0YzdDYzVBaWptS0VMcjVrNlJPZkpuN2JkZld0OFJGTVhKNkdi?=
 =?utf-8?B?UWhQQUVoVUpNTzE1ZERHQ3NPdjlQSDNSRTNJRmtSZHBUcXhHeTk5c3ExNjBW?=
 =?utf-8?B?NmxPVk15RFpDUzg5anNlK2ZyUlRNUjFFc21hcWhKTkFBZkR6UUhnVDQ3andq?=
 =?utf-8?B?TWsrZTFMeEQ1M0hnUnkrTmtxNUNsR2NKWWtMRkJ4TzlUNkQxcFRmdnMyK0E2?=
 =?utf-8?B?cnFqSnFvajdQeHFWeFZTaXpweFRsRHl0c25jNVc3R1gwREoyMXhWZENuVGIz?=
 =?utf-8?B?YksyOHB0SW5KNmJjN3VpLzN0ZFRERTdZTnlYMk5MT3NoOThlWE8vemIzQnho?=
 =?utf-8?B?TUhvQUdKN2VkNTUxQm16RDNKTThFd1ZNcW9XWVV1WkVDd2NubThha2RtMmRv?=
 =?utf-8?Q?spHjV/TYBv//boAqwYk3yJ0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbee90d-4b23-4c3c-c72c-08dacb4b21e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 23:01:19.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS+rc0tvNddDn537z5qp07wBXTTKbL7t+sXOQibo2J/LwkyGjIbW7YPXA/ejaSRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/20 19:19, Hendrik Friedel wrote:
> Hello,
>> This indicates you have a physical problem with your disk - I would 
>> try swapping the cables. Try and fix this before you do anything else.
>>
> Yes, I think so, too and I will work on this.
> What I do not understand:
> Why does BTRFS not cope with this without filesystem errors? I mean: I 
> have two drives. BTRFS should mark this one bad and continue with the 
> other.

This happens for a very critical operation, barrier.

Btrfs uses FLUSH command to flush all the data in the disk cache to 
non-volatile storage, thus btrfs must wait for the FLUSH command to finish.

But unfortunately for your case, it looks like the FLUSH command failed 
due to something wrong between the controller and disk.

If the FLUSH command got missed, btrfs has no way to finish its wait for 
FLUSH command, thus it hanged.

Thanks,
Qu

> 
> Is this expected behaviour?
> 
> Best regards,
> Hendrik
> 
> 
>>
> 
