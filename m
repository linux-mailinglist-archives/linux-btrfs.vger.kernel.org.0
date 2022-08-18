Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC11598256
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiHRLeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbiHRLeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 07:34:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBB3F302
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 04:34:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IBOHCJ021540;
        Thu, 18 Aug 2022 11:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R/95g/zL9sJmK7tRxljwEeSJwryibQnN/YQ5hxrYve0=;
 b=hzJ7Hregl1YtvH7AL17ZLpUn4Dye69vxglepjl4XMKN2Y2TCbeBCfcN6uCpaRZuZeeDm
 ddJ8GVisXxqn7gZS2yeM/bc+nglmpA0sfZjE4JgUG9IvT8nAL73rP5BZ1NIWAKOXrdqY
 Thh/ALi/mXN4gWQg2ZR8iasSFsaBYturG8G+n2QtpceugQRfMuvJiWBBcblTJ0XLltXi
 rxH1VBdGvTBzKpuUMtCpH4pIfjOT6caUQDGVrA8+3CsU0vkOUs5l/wFUjTbJvnKmFe4F
 oHfZccW/B2cp1wYkZ8lWv7W9e0126uStMzoP9l9JCbvZi/mh92jREmNQBjekdjVBW4uS Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1mf300s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:33:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXrIN005702;
        Thu, 18 Aug 2022 11:33:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2daev7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhxv+rKkzuGtu+2wWNr/e7EFli/VJfodKY25BEYPiPqcaWAqkhQQeS8ZoICOGKt7SrHAvm59tV+6dxtkyzF8n6TeLViwFSheiVTp0jOK+qnwNvUwRrpxDXgjo7EDwdvrqSVNjK28k2HDNzu1IYmPmZt++tmDLdxm22FLGTeWbTvWsKfCnZ/i/PNQtL9LGg7Oyqs86ZcWwqaF7I6gnxou/Ojk6UF/avVK/YERmh1jtDUjX4wO4dYns29JvEPR7ssxVSwJTZjHYW3nGBabvqeaIkPDFV40n9NLSlcxACZQOs3vm/la7xDml6jUd/RtFe4SchdPypZqpj/SefedI3Da/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/95g/zL9sJmK7tRxljwEeSJwryibQnN/YQ5hxrYve0=;
 b=CJCa5HYJKeRMR/ZKF01T0MHbV7wggYS4Nzz3WbHsrjXZeHseiy7secTpHj5bxdZxd8KSSzzDTKGJHykKxo1RAh0cF6epTCkor843f8A8jaskFRxOgd5KaMICWIqTpFgVc4iw/wybPaqmBSi54rbNj1j3+3btrfnj0/b6jbJydJujZq/f3dLPI3gSIpFE0KzhbJdeOgiVpQheKP3LLSFCQPJriHi0WLxu1HNsDczZjq+N9MOEU09B0h/euxTLvM7u2i1AeA9bA1KWWHm5PNAK67HwZB4LVD/vSmM06cAOCPNFxEzFUEI8PQLgNYyEIhRhimSV+IZ+beIMItLphHMdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/95g/zL9sJmK7tRxljwEeSJwryibQnN/YQ5hxrYve0=;
 b=rswXT+puJaAsfOYJcZNN5AcOEM5a8ZqmJs0AnYR8sQX+i6KkGmyamD8XIZoCONRAC2S+XRUVaqQvWqPw1F4EH1woIdiV481YOnXPLAdu7n92fvL28cdmlw42910G/PWezjvrQsEXzPf14cXvR60vnkE3XFd5Wya1yLGYTAKYAwc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 11:33:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 11:33:54 +0000
Message-ID: <59dd66aa-8917-5dab-f368-61294ff3f0cb@oracle.com>
Date:   Thu, 18 Aug 2022 19:33:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-6-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917ead9d-b4ca-46ff-ef56-08da810d8825
X-MS-TrafficTypeDiagnostic: DM4PR10MB6183:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz6/MEDF6tBX2+xyvcXMbM9fFP/jIdFzd9yOTgS3ulWHJbvlMpmhr3NifcYQDMg1NUDwVofxLotojHRufWQ+HIBc6w3u6hU8FSm1kofMLU5vq0spHFlIFsfoq4g9NhjiXtGDl8OkPucbpLzlyEvTorbU9eJ/t9PRcMTU6E7dqj7/Y8kXdIRVDYIgO7cZJXhK+XINB/c7ap8pc/gsDZI38Pd7Lq10QrHj0J7oMwoCymbVQNLMtyIuQur1FVdNdmTpTrRNEfSQ2bS/g1WQqcnPGa5BjtXSfXLtWJEW1hjgtIbmbqruxumX0hWSycRyx0hnYGARuZLuBQYmQ+EwQfS4pwY/mC8sM55HbIz9L1twlmuY2+IgTxSYYW9hVk3AvWuBJv2oridjZ8g0QysCg09kug347+6IQ2fj7Xtfqq/MIvxtK/Uis5b4rxm+sIMELfNMufTuEIoqpWOLrYXy/TDqtOCYMKh1n4Nh25BSqYt6TT8JzSR5rPZLi9gALfXD26cimI3PovO8isVhzD1zCZoBFIDSiBdGHcDzzzB9MaoWNYLy3lxiw8Wcy+4nT0TqrK/4LA6aAfWh9lCG1Uiha/cw6hdFEcEmsfZDKGrF1S3fcTC5AJIBoCChQfOIRi3NkmissoFUY1T3tqn9NSYDBE7BW9YZqYTrBVg+dTtanBzwpLZa/0LmdLOS2VG0BKNxWWWATeOvAPW5frdT9nX7iORWcIjm/1VbNea+DMeMcInLryU/j1Y5ObJwwC8HQNgVDIM67lgrclB4s+AFK8mH8YWd+DNZinU5Ct9s9rpvRYqf4m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(346002)(39860400002)(316002)(6512007)(26005)(8936002)(83380400001)(86362001)(66946007)(66476007)(66556008)(4326008)(5660300002)(8676002)(6486002)(478600001)(31696002)(31686004)(53546011)(6666004)(41300700001)(2616005)(6506007)(38100700002)(44832011)(2906002)(54906003)(186003)(110136005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVxRzQ5REhNdlFMWHZCWEhhRGhoV0pTa0wvaERJWWs1eDRKWTRmSjZEd256?=
 =?utf-8?B?ZXIvUzJOUW9ERnJhTFRjckQ4Q3RCdmNqdUJJaW8yb3grOHc4TTBqRUN2eFJO?=
 =?utf-8?B?MHhDV21GMWlYU0oxcXhtTGVSS0l6VlhUMmNRM3pZb0h5Uml4bGcxTHg0Rlhk?=
 =?utf-8?B?MDI5NUFYbmpmWlFJTDR6WHAwd0FpSVIyNEpMK0VyRU1MQmx6aUdNSXIySzNX?=
 =?utf-8?B?cm53VzE5ZEpNMjVaemM3Vy9pNUx1dnZrb3V4VG9kd2RPYm5WY1NBenRVb0xh?=
 =?utf-8?B?VXBwN2s4UHZtYnVLRGNrWFh5VlJ1eUFPbVM3NUtPQXEzVFlleFU4TDU3ODFz?=
 =?utf-8?B?bVl0WmY5Q0c5NWsya2FiT01UWFIwUktUWGVBKzljSSszd2prZWlXZ2Z1a3ZX?=
 =?utf-8?B?WldycU5FSFFCSEVYWkVaVmh4OFZOQTJLWUpkSXV6dWgvUzJUb25TN3d0RnBq?=
 =?utf-8?B?Ym1hUUNGV0UwU2kwQTlYcHJWdmlub2ZwVXhBbjdHVnNYam5DMjA2ejRLSHZL?=
 =?utf-8?B?M3V6dEhTMGEzMGxVa2J3UDBCMm9KcDhETm41Y2FwQjdpdE1aZnhYVTZiREFp?=
 =?utf-8?B?dS9LRlFvWlhOQzQ2bloxWXJnU0R5bG51dUd0VldUT2I4K3d6WTA2S296Umg4?=
 =?utf-8?B?VWg0aUM4N2hzRTJaZkZSbWtBajMwNjNqMkt0TUMxU05Zclo1bllLdUxiUEVK?=
 =?utf-8?B?L0xlRUZUcUJ3YlV3akQvak1QS2wwWmV6TS9aN3JYdlpsbUx5WDVHOTNyaVlt?=
 =?utf-8?B?RnpZSzd5ZllXVkNGZFhoUUwyODNweXpKTjljMmI5dkdraUVJWVdTdTNvWVJp?=
 =?utf-8?B?Ri9RWWVlb011cWhXL2YrOXphUDhSWVlIN2FRNkcxcjFNdHMrQlR6aEtzeWor?=
 =?utf-8?B?RUozR0hTTk9BaTVoRi82cWRSMVFCQjUrd3BWc3hVY2UrSWpTSE1INXVsdWVN?=
 =?utf-8?B?aWpwVW1ZTUVtek1FNHQvcHR2d3Q2S0lGa1B2QmFoUXp0WVlTRlAyV1hyZ1R5?=
 =?utf-8?B?NlVVd1lmZnZMUmVTc3Y5bjFOM1pLQUFTNFpxblZGQVVOdzM2Z2tKK3ljRDhw?=
 =?utf-8?B?dzVYQkd6NjNnRVBJZVhuTjd6K2hFY2V1dVI5ZHlqZ3QrQjZZd3Rma2wvUFZD?=
 =?utf-8?B?eVJXRWVoTEtYYnowYzQ1K3VrSGw2SWxQYjZJRnJPNTlxZDYwSzA4NGtIRnpD?=
 =?utf-8?B?cjMrcmtRUFpLbFJTeDdZOXd1VXdUSDB5SFJiMnRkUWNDOHZDY1Zab01ZRlRt?=
 =?utf-8?B?WTZGeUJBVmFMeW9LWTBSMG5mMTYxWGQ3djFmNTdOSE9PcCt4Nkh5M2pwS0ZE?=
 =?utf-8?B?eFZIMzZnOGprSElRU2ZDQVhVNzZUOFhKOG1xUG9hSjBNVXU4YVJ3U2ltbUNG?=
 =?utf-8?B?bGdQWGpvZlg1RGdIMUJzeDdrRDhJWHFhRU1UVUNubWlYbWtQMTZidnAxekZC?=
 =?utf-8?B?eUE0WU9XQkZzOURZN09za0RzVEY2WlhHeUp3akMxLzhCVHRVV3ovZ3pCQjJp?=
 =?utf-8?B?NjhrQVhsT085WWVSS0NiUjRJQ0FQa1U0bmc0QUJXY0R0MWJwdnZOVm13TElW?=
 =?utf-8?B?VmNhcndvd3RYcDFOVTF6UjNKM1BQekdmQSthTXdLOVdNSy9CSkcvRVgyOTcr?=
 =?utf-8?B?TW43YmhDNS9OK3VGK1BuTzcyUU92QVN3ak1GMmEyRkM1MXNDbDFGd1RINTM1?=
 =?utf-8?B?V2RaZjRzbDZ0YmwyZjdOLzFVQlJuTzUzdWZJcmZBMTE3S0Yzb0xuNkxKUDBB?=
 =?utf-8?B?QTJmK2JZN0tpSEg2dU5Eb3ZkOWdTaDJEU3VxaVpzRG51ZFREYWVGcXIzMWlv?=
 =?utf-8?B?bWZNd080YUIrUk5LdHNGMUlRQkhyUUp6VGhDT0NIcVFGNjFDREJFK0NHajI3?=
 =?utf-8?B?S1lQUFVHRWsvQmxvWGVJbVFqVEJsZ3AyNTFUN1BTdUJqczMzNnpvZG1PZE9j?=
 =?utf-8?B?cHdGQnlHVE1qRXZPWHRKMi9TODR2SS8zVkQvY0ZJRHpEVjM5QTdoOTNFNndK?=
 =?utf-8?B?YnArSHZUUjFGbW9qMlJmczd1czRBSGg0Y3JoOXRURVBoVmpiUTFsYWpoS3Vo?=
 =?utf-8?B?b2xEMDlrcWRJcHNrSGZFQlNvVkxYVi9QQVp5dzN0M3JzWVUxbDBFb3JLWHB4?=
 =?utf-8?Q?7YAsQfHZDgnZTHWvaDfe7ThDd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ajk3SzBJdzdJYisxVm9mSDBOVjZrLy9sS21hdC9CQ3Qrem1qYmt2Z1g3ejRZ?=
 =?utf-8?B?alJ5UlIzdFRZTXhOcFN0TVd1bzVZbmJFZGlsTVNRbXFnS0x2S2ZmWHN0czBJ?=
 =?utf-8?B?R256YXpLbHFRMy85Wlo5Zzk3MjlnZ0E2d3hVTm52NlpJOVpsSFRLZ0hkRXdV?=
 =?utf-8?B?NktmRlJCaHdmbitRa3BvTEs1b0ZTZnFacjZJYUlKcEpRbDlDTEFONWp1c0VW?=
 =?utf-8?B?bmFqaEJTNktHMHRpU3h3RDhqNlZhdVMydmxkZjRZYjhZcjZTNzYvQTFxeEFF?=
 =?utf-8?B?RldvV241N21xbzhIMGVEUktQbkRRNTExNVhhV2QyTGZNcDJtU2ltQ0M3eGJR?=
 =?utf-8?B?MUcvN0RTNnFCMzk0YzB4ZjRsQkQrd0JBTEFMS1N6TFgzdEJOOVUydGlsTkFW?=
 =?utf-8?B?aElBOHFxS0NzdWVmaVVQazV3YTlRLzhPajNXcTJmQ1NxUjA4czhFL2I1N3Qy?=
 =?utf-8?B?WEdnMEZncmVmR1cxUEtlMXNhclpVcVpEdnFJOUt5NVIrazJ4TFIwQVVuNStN?=
 =?utf-8?B?SkJjcGxLYnRvM0pJMzIxTjMrWE9ZZ1VscnUyTDJzbHQ1SHE1RHFWVlNqbE5R?=
 =?utf-8?B?VjZqZzNOYVYvaUowVjZFUzI5WHRhanhzMWhVOTJaalpvblgzeHpBWjRReHg1?=
 =?utf-8?B?NTNsZm0yR1prOWdBcEhra0I1V0plY0Q4L1pFSEpXbnhqVVZPUk9SUW44Y1hr?=
 =?utf-8?B?QlJWZDlvMnltZkQ2Vml6NmFJLytVNmlQT0tTMnFSRVBSc1VGeE1LUHZXdXNx?=
 =?utf-8?B?WGZuYkpOdHM2a0RrRWIySjVTMUdTNlJPdEFhUWpuQXFOVitRSk9mS1dhdnh4?=
 =?utf-8?B?ODF2NlpPMUtHQTZJV0VZRnJCZlROdFFmQ29aYmVMNkFISm1vNnl3d0kyb2ho?=
 =?utf-8?B?QXpVOEE5UG9LVHNXZERxdDQ5N2hhbWkrOE13YkZFY3VCc0tjNWFxVVJDR2hR?=
 =?utf-8?B?dnlIaGU1bXJybDRNN1haTUhMS2tvU0ZFVTdvV0JIcE5oV2JZenNic2k2TWlp?=
 =?utf-8?B?UGs5WHU2QWxvbjdSMTZzMndsRXA0MW1mYU1NdUgxNVVvd05ZdkdZNkw5Qm1H?=
 =?utf-8?B?ZCsyZXJGU2NIZFVhZWhWTzdNdHlselBPc3Q2K3h2NkJqZkhoSm0xWXdzblQz?=
 =?utf-8?B?ekJwQ2x6SmpGM3BhZWRNbDEreUFHT0lwOVluOGVZZU1qcTdUL0FTT0VoRGRy?=
 =?utf-8?B?eVl1RTdSYkR6c2YycHU2d0ZIS21icFNRQjNDRm9CcWJpSG16elZuRUNpZnMy?=
 =?utf-8?B?b0J6YUYvTkcxdHFWR0M5VU81bTJ6SEVtTUFIMFFTd1VwMUF6NEE5UlozMVJ4?=
 =?utf-8?Q?fZMO3R+yNGxND+gKJEBK0HWnUlo6YgnWcF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ead9d-b4ca-46ff-ef56-08da810d8825
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:33:54.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOuj6WmgknFOtOBctte7kOVSHheb95ZY+6ANPV0Hy82xhtdEVMZumvMUhWl2LzA3huu55iSINKaiCurvXz9oFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180039
X-Proofpoint-ORIG-GUID: wwW9J0t6wFfzAfglWTfsyuG5T8DKR4hs
X-Proofpoint-GUID: wwW9J0t6wFfzAfglWTfsyuG5T8DKR4hs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> The stripes_pending in the btrfs_io_context counts number of inflight
> low-level bios for an upper btrfs_bio.  For reads this is generally
> one as reads are never cloned, while for writes we can trivially use
> the bio remaining mechanisms that is used for chained bios.
> 
> To be able to make use of that mechanism, split out a separate trivial
> end_io handler for the cloned bios that does a minimal amount of error
> tracking and which then calls bio_endio on the original bio to transfer
> control to that, with the remaining counter making sure it is completed
> last.  This then allows to merge btrfs_end_bioc into the original bio
> bi_end_io handler.  To make this all work all error handling needs to
> happen through the bi_end_io handler, which requires a small amount
> of reshuffling in submit_stripe_bio so that the bio is cloned already
> by the time the suitability of the device is checked.
> 
> This reduces the size of the btrfs_io_context and prepares splitting
> the btrfs_bio at the stripe boundary.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/volumes.c | 94 ++++++++++++++++++++++++----------------------
>   fs/btrfs/volumes.h |  1 -
>   2 files changed, 50 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 014df2e64e67b..8775f2a635919 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5892,7 +5892,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>   		sizeof(u64) * (total_stripes),
>   		GFP_NOFS|__GFP_NOFAIL);
>   
> -	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
>   
>   	bioc->fs_info = fs_info;
> @@ -6647,7 +6646,21 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
>   	bio_trim(bio, offset >> 9, size >> 9);
>   	bbio->iter = bio->bi_iter;
>   	return bio;
> +}
> +
> +static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
> +{
> +	if (!dev || !dev->bdev)
> +		return;
> +	if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != BLK_STS_TARGET)
> +		return;
>   
> +	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
> +		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
> +	if (!(bio->bi_opf & REQ_RAHEAD))
> +		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
> +	if (bio->bi_opf & REQ_PREFLUSH)
> +		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
>   }
>   
>   static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
> @@ -6665,62 +6678,54 @@ static void btrfs_end_bio_work(struct work_struct *work)
>   	bio_endio(&bbio->bio);
>   }
>   
> -static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
> +static void btrfs_end_bio(struct bio *bio)
>   {
> -	struct bio *orig_bio = bioc->orig_bio;
> -	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
> +	struct btrfs_io_stripe *stripe = bio->bi_private;
> +	struct btrfs_io_context *bioc = stripe->bioc;
> +	struct btrfs_bio *bbio = btrfs_bio(bio);
>   
>   	btrfs_bio_counter_dec(bioc->fs_info);
>   
> +	if (bio->bi_status) {
> +		atomic_inc(&bioc->error);
> +		btrfs_log_dev_io_error(bio, stripe->dev);
> +	}
> +
>   	bbio->mirror_num = bioc->mirror_num;
> -	orig_bio->bi_private = bioc->private;
> -	orig_bio->bi_end_io = bioc->end_io;
> +	bio->bi_end_io = bioc->end_io;
> +	bio->bi_private = bioc->private;



It looks like we are duplicating the copy of bi_end_io and bi_private 
which can be avoided. OR I am missing something.

Here is how:

Save Orig bio in bioc:


btrfs_submit_bio()

         bioc->orig_bio = bio;
         bioc->private = bio->bi_private;
         bioc->end_io = bio->bi_end_io;



Only non-clone bio shall use the btrfs_end_bio callback and orig bio.


submit_stripe_bio()

	if (clone) {
	<snip>
	} else {
                 bio = orig_bio;
                 btrfs_bio(bio)->device = dev;
                 bio->bi_end_io = btrfs_end_bio;
	}



So again, we copy back the same content to it. Which can be avoided. No?

btrfs_end_bio()

         bio->bi_end_io = bioc->end_io;
         bio->bi_private = bioc->private;


Thanks.

>   
>   	/*
>   	 * Only send an error to the higher layers if it is beyond the tolerance
>   	 * threshold.
>   	 */
>   	if (atomic_read(&bioc->error) > bioc->max_errors)
> -		orig_bio->bi_status = BLK_STS_IOERR;
> +		bio->bi_status = BLK_STS_IOERR;
>   	else
> -		orig_bio->bi_status = BLK_STS_OK;
> +		bio->bi_status = BLK_STS_OK;
>   
> -	if (btrfs_op(orig_bio) == BTRFS_MAP_READ && async) {
> +	if (btrfs_op(bio) == BTRFS_MAP_READ) {
>   		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
>   		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
>   	} else {
> -		bio_endio(orig_bio);
> +		bio_endio(bio);
>   	}
>   
>   	btrfs_put_bioc(bioc);
>   }
>   
> -static void btrfs_end_bio(struct bio *bio)
> +static void btrfs_clone_write_end_io(struct bio *bio)
>   {
>   	struct btrfs_io_stripe *stripe = bio->bi_private;
> -	struct btrfs_io_context *bioc = stripe->bioc;
>   
>   	if (bio->bi_status) {
> -		atomic_inc(&bioc->error);
> -		if (bio->bi_status == BLK_STS_IOERR ||
> -		    bio->bi_status == BLK_STS_TARGET) {
> -			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
> -				btrfs_dev_stat_inc_and_print(stripe->dev,
> -						BTRFS_DEV_STAT_WRITE_ERRS);
> -			else if (!(bio->bi_opf & REQ_RAHEAD))
> -				btrfs_dev_stat_inc_and_print(stripe->dev,
> -						BTRFS_DEV_STAT_READ_ERRS);
> -			if (bio->bi_opf & REQ_PREFLUSH)
> -				btrfs_dev_stat_inc_and_print(stripe->dev,
> -						BTRFS_DEV_STAT_FLUSH_ERRS);
> -		}
> +		atomic_inc(&stripe->bioc->error);
> +		btrfs_log_dev_io_error(bio, stripe->dev);
>   	}
>   
> -	if (bio != bioc->orig_bio)
> -		bio_put(bio);
> -
> -	if (atomic_dec_and_test(&bioc->stripes_pending))
> -		btrfs_end_bioc(bioc, true);
> +	/* Pass on control to the original bio this one was cloned from */
> +	bio_endio(stripe->bioc->orig_bio);
> +	bio_put(bio);
>   }
>   
>   static void submit_stripe_bio(struct btrfs_io_context *bioc,
> @@ -6731,28 +6736,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>   	u64 physical = bioc->stripes[dev_nr].physical;
>   	struct bio *bio;
>   
> -	if (!dev || !dev->bdev ||
> -	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> -	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
> -	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -		atomic_inc(&bioc->error);
> -		if (atomic_dec_and_test(&bioc->stripes_pending))
> -			btrfs_end_bioc(bioc, false);
> -		return;
> -	}
> -
>   	if (clone) {
> -		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio_inc_remaining(orig_bio);
> +		bio->bi_end_io = btrfs_clone_write_end_io;
>   	} else {
>   		bio = orig_bio;
> -		bio_set_dev(bio, dev->bdev);
>   		btrfs_bio(bio)->device = dev;
> +		bio->bi_end_io = btrfs_end_bio;
>   	}
>   
>   	bioc->stripes[dev_nr].bioc = bioc;
>   	bio->bi_private = &bioc->stripes[dev_nr];
> -	bio->bi_end_io = btrfs_end_bio;
>   	bio->bi_iter.bi_sector = physical >> 9;
> +
> +	if (!dev || !dev->bdev ||
> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> +	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> +		bio_io_error(bio);
> +		return;
> +	}
> +
> +	bio_set_dev(bio, dev->bdev);
> +
>   	/*
>   	 * For zone append writing, bi_sector must point the beginning of the
>   	 * zone
> @@ -6801,7 +6808,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>   	bioc->orig_bio = bio;
>   	bioc->private = bio->bi_private;
>   	bioc->end_io = bio->bi_end_io;
> -	atomic_set(&bioc->stripes_pending, total_devs);
>   
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>   	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index bd108c7ed1ac3..9e984a9922c59 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -454,7 +454,6 @@ struct btrfs_discard_stripe {
>    */
>   struct btrfs_io_context {
>   	refcount_t refs;
> -	atomic_t stripes_pending;
>   	struct btrfs_fs_info *fs_info;
>   	u64 map_type; /* get from map_lookup->type */
>   	bio_end_io_t *end_io;

