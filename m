Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA13F540E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 02:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhHXA3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 20:29:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50144 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233260AbhHXA3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 20:29:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O04PrQ007612;
        Tue, 24 Aug 2021 00:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iHTXbs+Q9hXAm8OzOPeS5iRvNvMgsDEb3ARfikxQccs=;
 b=w3dNeDAs0Dzu21axXD8R8o06ynb9xtSNrdatcUS+94pcd/N8N+sF1YgdEVToM7NOG1wH
 H2/w+Mk+M9X27pLsxHztVybQIfgMu5gkva5RsaEIqRS8Gz6iNQX3BdCah2w8ckiEt8Pp
 V9qvzA5hCE7H8oY9rPfV7eQ0EHPsrEYa0+ipc8u68Ia3RnV+/ude26630nwK+7WgQokv
 GeHzLylEHk3VW7CfcoW8HMPzcp2yN46/8eIxg88SiPWfcGyzwf2W1t9depcIo6xY5LQd
 EaDb2a8GfBCB+StExTEwgLCEh/rI5dQkpNKXTjVV4VnMz1f5HI7u38xF5nP2CZWYR4CI Mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iHTXbs+Q9hXAm8OzOPeS5iRvNvMgsDEb3ARfikxQccs=;
 b=hxZ+Zb1ORNOlmpdvSjSioz5U4SIX9CFGLZBKfihhDakb3jJ7NfXMc5F20u0FR4zfuWVr
 ErVPpJFIrbe6txr0kwUli59ZIEwf+aMD22IdEjYkf+0NplwSW64UZEa9BroNrRjmmOBi
 Ki+AF5gyc5B3Zxb40dYAJX4EX4AJSV91oKfszvOfszRmCZs8FbD+YQVPs1O3uF6FDGw/
 Dr36c9ZUjYtraA+qzDSIKFhpYDiHs8VWgPPlNcGRMkHOlpgIFWqmaK3Z8I2nXFifoKKd
 vCz1h4agqMXUmXYR1VAGDxyg/Sbttv0hR6IYtTIrC1ZCDRE3ILrEBViw3IVGDiSSBuO8 GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7nb053-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 00:28:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O0BBv2026232;
        Tue, 24 Aug 2021 00:28:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3ajsa499bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 00:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiKijFj/Mym0mOV1EJ5P48JQBTRxL7Y0Dn+zCVpBge6JR2wi4VTffHA0ZW31zpG1uMZxw3DODZXbkNeItDhUENRUpslSsmd6dJ7xOSpUzsJMa0Wm0uqDMwCXpj3UhVZTzTVC6bT5LRenC13eT1uf+zLM9PgqbOxIqqUOIkL1JPRiUFSAMtTmNHfHBHqjelT2xzcXNsaHnlJe+T5hga+9GlN541cn+jrNio+vL7P9i/iItW8yx0qWHQHZzMB7R7yUoosccS+hPSIG0ASpwExtZV6jfUSfQkVAAmvZ5e7CRvMBvchQ+nDPzYYK/1y/r04EjRmDudAsX7YXhlYWBZfuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHTXbs+Q9hXAm8OzOPeS5iRvNvMgsDEb3ARfikxQccs=;
 b=E7wLaW7TlSH4s7Sex8WXGhEr7rMdzR8UmutJ7LlSjlJc31i+9H5EHsAAsaXWkPpwoP9ccUVTqLzMqvq/1FKzCdizJ6v2CAB+Rngt4mpt9PO4SH2q5UUVeZHFkkHXAFBK2kLDcKfXFShqOglRde6rmZsBW3f50y7vBvQ7H0wJjN++DvS/Z9sswrNEFhOS0wLIk2Yf8TnV7Sywal81PTciGD2qwQTzyhdsreqNo4LsgJzp+eHpm/SRIneipBIc90bhZHmdcEPhSbvJ07XGZcSxVDu3YuddKL9Wos6qJxr8+dCAVo5sTyejGfx79t5F49FPw8gf3m/XuvlHMAU4tj0BQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHTXbs+Q9hXAm8OzOPeS5iRvNvMgsDEb3ARfikxQccs=;
 b=YDJUPcznrjB4y0/+1viawq3zULynB/1bBfEtzL0MkILa7LgLbBOcT+g2Ksa3PQukNsc0xHxI8UIexc6+BilkYmDSPtCjsQGb71ylP61JRqapGgKy00YdPXUF+xBPyGYI6tGncLswVy7iiGFk6JHTG7jNTf7GAF2BzcTUGkhAflY=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2803.namprd10.prod.outlook.com (2603:10b6:208:7f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 00:28:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 00:28:19 +0000
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
Date:   Tue, 24 Aug 2021 08:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210823194618.GT5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 00:28:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab792f9-68ce-468f-e3b7-08d96696125f
X-MS-TrafficTypeDiagnostic: BL0PR10MB2803:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2803BA7BDDDF14E8A0DB16F5E5C59@BL0PR10MB2803.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbOk4OMGzwCAbfD3eygp4RCOmq4awvEsIs4JL+352SsWOJkKgXpJWtpx50tt0g6c1BRn5AQJiy/r6e6yvikNNqdivZ3qAp6t5McAbRX/EjPnqXRGFkWAjb/O3WDYQE/F4wvCAnfYWcEg4Jfe+D8hBS3A1kR0K2pz1v+H9KowYcuSEY064cTaXgMFv4F06OqHThfcUxOFKRYOxyT2/j8YhcNbwgQbmYRWQBgo62PmoGmSt0TaWy2YK4C8q6cTMrmumXXL/L68cXTXGwfR0T3vRD1tAhCeu6OrV5+eyx6mzkOlHPsxYuVZ9brnj+bChMGJAbc/U+S4RAefsm/5iKF17S6GpWPgNfO+DNY1k+Z+sR18jBmTwhziEtd9bbG4CM8CnnLQQLJqXCGLUARS5/xTa+djpK4TjoUVspjePZ9/8Q/xd+RXz0wDVSGi16m5F2dLxDXvJzqojSsTi6s08HeUl37M8n01kj3synxKcawHZ1xRCwjF5225UGwaHUsZRJkpp2WNODVZrHaso3fTSV2Dz+FkcsgT4qIX+kgRKNd/yK9Viq0NvkSMhv8eIeV1NTJgOyd1C78UqN8PCT7ssbFzO/Yb7307/BuqidHlLTZlHK7+2KGxjFZAJPdZTWG1ALiurS3NeBQ8WP52UJsEU/UmAuVXdvS12WX7PUZcOfIeLDI3PpSJroPxrle/D55ytBkv2t0DSALSnrAkhNz/1qrlZi4RZGLKCnAUIMUFOahzugs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(39860400002)(366004)(66946007)(2906002)(66556008)(66476007)(31686004)(38100700002)(31696002)(26005)(6666004)(186003)(478600001)(86362001)(8676002)(83380400001)(53546011)(8936002)(5660300002)(16576012)(6486002)(316002)(36756003)(2616005)(44832011)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZhRy9VdDdOS1hJd1lDWmtMRTJpbTduc3hLeHF4WWVaa1pkK3A0VHlQeW43?=
 =?utf-8?B?UERlRXJZMDBLL05tTEVGN2RLTW5WaEdIRFJsM1V2cUMxSDd0TVVzeTNhYk80?=
 =?utf-8?B?Y05GZjhRR0RRMzdzMGVQdHlCV2t0WmhVVGpYRUM0MGZYd3ZiRlppTXpQK2Vi?=
 =?utf-8?B?azl3bDAzSXh1WkIwekQ3cU9jb2lZdVdaQ0dkaTJGaml5MlRPWEhGVnN0bUZp?=
 =?utf-8?B?V2YyVGptZ043SHNrVVBoVHFZTmgyU25Md2ZGY3lodVUrU2ExdGVqQW0xZVB1?=
 =?utf-8?B?aUFFSnZqTjJzb0w0cmYvSE9XeEY2NFh4NVh1b3BUYlhBSWtFenB1dHpET25z?=
 =?utf-8?B?aVdYRC9IOEEyTURPOUcwalJpSGdyRkFWRkUxOTJxZCt4b1pmUjFPeE02WkMr?=
 =?utf-8?B?T3FKSldJek1IUlplUXZGMUs1YS9POTFjcWVpeUpWSTRTSmVudFNxbWpDQ3ll?=
 =?utf-8?B?YmlJdm1WL1l5citNaW1iZitud05mZzBpdzhsdDREaFIzU3dkRFZNdGozbmFl?=
 =?utf-8?B?cnRGMWI4OGI3c3BDUHJhZC9LaDF5aTZnTDR6WitCb2hHSVpjUkZ4d0IwdlIx?=
 =?utf-8?B?bHAwMklQZFZvL1U3NkxGVWZTdVJ3N21hbDRwN0k1Zy9EMzVHbTVDN2J6dStW?=
 =?utf-8?B?QmMwdnFJSE5RTlpyVVpyYVg2dEVvMFlJWjg4YUdwcThDV0VkNHFmOHdZVzNL?=
 =?utf-8?B?RmpMS25sVFJGZ0FWbkhXdVpmYVVneHhuQ21jVFI4V3NEYjVLcFRZMVBBVHU1?=
 =?utf-8?B?TDRMY2F0NnRDRWdDVG1tZFRyVytpNWw0Zi9zaDJEQW8yYWQ5NzYwUk5NdFU4?=
 =?utf-8?B?aUxBNTFzYkQwWU1zTkl1NzFRN2Ryd2VaMktqVTIxQUQxV0ZBMzdsY01YcFkw?=
 =?utf-8?B?U21hL3I0Mk0xQ2ZNK09ZL0NMS05pN2l4bWhHUHVQYTFPQllMT2xtT2s1TWlN?=
 =?utf-8?B?Y0dkSnNGanFBa2gxVWJuYzZuL3lxNjdpTDRmYkJ5NGpTamMxTmVaL2cxdTFl?=
 =?utf-8?B?akU5QXdvUW43TzlSQzBUOWVQS1A4WDNLU2RCSDNhUkxHbGwvK3dBWmRuaWdH?=
 =?utf-8?B?N0lZd001UC9GdHd1L2lCRDdoZFpFc3dtSjNVaDBjYUV2VUxXY1d1WVdUamJK?=
 =?utf-8?B?Mkg3Z3dPTHlybU9LSnpZRGw0RFRaYlNYbGhhdzE3Vmo3bnBBQkIvaWhKN0k1?=
 =?utf-8?B?RU5WWXBnckFlVjZJZy9JTGJ6L2VSK2I0U0tjZS91anZaZk5HWCtXTmY5WHJh?=
 =?utf-8?B?bWxIVStIT1FmcEVPOU81UWlnbGtjTE01eWRzRDdLVGd2RmJZWU0yNkNlT1li?=
 =?utf-8?B?QnYvcisvbG5uR0lMVzV4UWFISXdOVjBVS2Vlb0kxZk5WMXBQcjYxRUxkemx4?=
 =?utf-8?B?T2tuVUVtVnNiTDVQbnBsQmI0SjR0Qnk1d2hzcjBGZkNuRnhCUEZzSms2TlMy?=
 =?utf-8?B?RXNaeXVOV1pmZUtqT1NkSitGZitmNGR3cU0zSDJ2dEtPQkVZcDVWRWZsMnQw?=
 =?utf-8?B?M3lSbnVpMUw0SlJuVm5ER3gzT09Jek02WWhTUlc2S2tUbXRnY2hIa1BFYmFF?=
 =?utf-8?B?SkpQT0U4WjhxamlCS3dWWDdWYkhGT245aVNraW94Q1h0NkIzOFFrYXBWYjgy?=
 =?utf-8?B?cXVndUtzejV4Tmo1c3FJSEd4VjNGY0d1Z3VTMXBkcC9zQXZ3N0pROVhSTDE5?=
 =?utf-8?B?elozZ2VEUEFOa3ppSk1OWWV5UldEVEt1Um00bExMZ1hrK2REMy91T2tQSHVO?=
 =?utf-8?Q?Xw/hPuA0Cf2zFehOcmsKNSIERUVhRbgPdzZcMsE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab792f9-68ce-468f-e3b7-08d96696125f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 00:28:19.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbus80F9/77yf8371g6GXnWaiT5ebBoYov7ZicwWmoS9xs9ly//hjnlVxv8tqDYDmVuoMffbMZTg18mFtyMBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2803
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240000
X-Proofpoint-GUID: PhTVreMvC5p1RV3uoS8egfwi0xQk-r_r
X-Proofpoint-ORIG-GUID: PhTVreMvC5p1RV3uoS8egfwi0xQk-r_r
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/08/2021 03:46, David Sterba wrote:
> On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
>> These fixes are inspired by the bug report and its discussions in the
>> mailing list subject
>>   btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
>>
>> And depends on the patch
>>   [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
>> in the ML
>>
>> v4:
>>   Fix unrelated changes in 2/4
>> v3:
>>   Fix rcu_lock in the patch 3/4
>>
>> Anand Jain (4):
>>    btrfs: consolidate device_list_mutex in prepare_sprout to its parent
>>    btrfs: save latest btrfs_device instead of its block_device in
>>      fs_devices
>>    btrfs: use latest_dev in btrfs_show_devname
>>    btrfs: update latest_dev when we sprout
> 
> Patchset survived one round of fstests and I haven't seen the lockdep
> warning in btrfs/020 that's caused by some unrelated work in loop device
> driver.


> There's a series from Josef to fix it by shuffling locking,

  Hm. Is it a recent patch? I can't find.

  Is it about device_list_mutex (as in cleanup patch 1 above) or 
btrfs_show_devname() (which patches 2-4 fixes)?
  Yeah, patch 1 is unrelated to patches 2-4 will separate them send v5.



> so
> it would be interesting to see where's the difference.
