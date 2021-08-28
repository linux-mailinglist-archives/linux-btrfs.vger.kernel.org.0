Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1573FA800
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 01:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhH1Xsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 19:48:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21042 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232475AbhH1Xsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 19:48:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17SCquXR031952;
        Sat, 28 Aug 2021 23:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c5eiDxPtme9KEPc8Y3O+BLB7dmSnHRshNg7hMAV65Zc=;
 b=nATd68ArECOPbSsDnWFHAEl3up1rVRjaXcWDXoNRKaSrCVh7I+jNlZ13Mvc7bdfIv0WT
 ZL8ZcLww4LFUZn4oo1Cn8LaLZ8JwpVr9aJqMCYQ1n3j4fgKd0Ex4EWVR6xQtIGHiiSlR
 MZdfZWXJm4969ft3kcTa7QAXTLCqvE7GatENipIrU/NURiC7ib4cGFN0xF4t99njCXBD
 hc5bws2BBi1WYpMTYudAHDAkTgVwkQOffP0J5O2CrnBT3She+FS4cfr5AIDnsxv1DvJc
 ITSomj6cRIx7EyM+VQTvOvatvT/6QDhhCs1KgDKoS5EG8sKkOuUp6GGws5xE//UWtjSk uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=c5eiDxPtme9KEPc8Y3O+BLB7dmSnHRshNg7hMAV65Zc=;
 b=ehHpmRSARFv3YCsS2WfIkw1SkczWT8vLSs9h7hA5yq8T3D29WA04EpWb2cY4feE7RhYZ
 Dl6WBg8oeLXSH+wX9wBlpBaJzcEMwrduLUvOyR796jor8v1vpZbewhn1GInkJk0hLAUM
 3KXlNREWxilW1CMqiFXuDZOtRDR68UJf3TtnvHuMF2NJjqYIAl+GwQAIx9tLJ1WHwvZL
 ROP55lYYEUDuqnV3akhPEhArFpdQfxVtmrEblK/AOPKuO9Oq7td8Neh8+jgqtKxtRsGu
 OC5/gNnY01jy/iH1ONv/3gXKUbmrM+t9jdknPOsGPsGkK/OHsW3HGj8Z2526uGCLneE+ 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aqbx20y3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Aug 2021 23:47:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17SNfSpd090779;
        Sat, 28 Aug 2021 23:47:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3aqcy0su0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Aug 2021 23:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ColYstCNG2hzB/38wLBgUUHTQu2pFl4HJhD70lM42GuUkNqcSHz7iPJUHTjAqMhCyh1LPKKZw9sp8HkNIgesM98YBAwKyiuMlZ+pVT+RwWGDU+sSNkMwNGseY+cZ/JDoJD4hy+caMjGvOTicMzNQN3pR/2g28vSGI4GLCr+cgtDrgML6B22y00aJ1xXbzVDOCavQYsx8Ttg7XNTsN4NbQf/21j8qIKuP87x/1XZCLjYe05uOd05idE2RESueN31H0mwhhgxfxZ2tOWGQ5xoPAREaxemujVaSjsBiC+CLHH0KeXGBOljr/EpJBGbZeped4v4kmzUx+0j2ztpfRJ/xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5eiDxPtme9KEPc8Y3O+BLB7dmSnHRshNg7hMAV65Zc=;
 b=SBMPpCUsmokQzNI9vC6SAf/YIh1+Aa2rkMWRjjsozQUfQlKJT6qqzubi1TH8mA4dRwswWQn6gWg5v4K5rtymUT5dctzzk5pGvEy8UXq76jssmKmWxnL+Jo0iLWSTcQuhGTWXkd8uCkriqImWc7bRO5BmDiLJUO17uKxyYpejnkZFZuLQVNbhsIltKEaHdVsE9R7GKcl2wK0DCQpzNYuFZurNHTRGR4GGBF9bfJdNVbSngaCxPQOV4M2R5cTDmYrczKZyh0TWgKAs5bYWpeAF/E7v09MxrBnwbedmJDiwFE+8a4oyghzvD1Qeb6YUQU6uRQ+ItSRIh4gxPmQfG9waoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5eiDxPtme9KEPc8Y3O+BLB7dmSnHRshNg7hMAV65Zc=;
 b=FdXH4EzVxJFhUfIk/8X9SdqkXpCE/iltfOxHb0T9auIZktERdOfQzo/wTeAgQjhS5hpd7c+MrIIiW9yZHUtgRVFkG/oz/ce2wNP/lG7MZfrSPLwbmv84wtI9Dqv2YOwh8wAXusUnuqCbl1v3ekSo/145rblk0ABdoP+3r8BXz5M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3982.namprd10.prod.outlook.com (2603:10b6:208:1bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sat, 28 Aug
 2021 23:47:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Sat, 28 Aug 2021
 23:47:44 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
Date:   Sun, 29 Aug 2021 07:47:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Sat, 28 Aug 2021 23:47:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f04e6c59-86d7-446f-f12b-08d96a7e3b46
X-MS-TrafficTypeDiagnostic: MN2PR10MB3982:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3982F77AC890F6248DE18ACFE5C99@MN2PR10MB3982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roHlZEE8T9Ua4jH/4KiLwdZ+s5rpE5bUDtCk+oZvHzS9JVinb82ugwwVkQD60hBsCHq4ZEYmrPKxjpNg2rABr7boe+vvlUEcHeujaVJ8+rWMj2n6YM8SYj4asmGuhHixe7zRt7GRIoDcEIlNAUYvcEqsj6ziRQ+suMMdnPx82yr0TSJwmOcART/3ZnIORV3bJVwKLEBYb+/i8BTGCFjcXbWzBUhN8Q8IOCo2MjyAIOHZULbLZYFK5E+L2DrP+uIctoXdpWACF4Q38zT2trybl9RTQd5juhROCXCQkvk3HRHrPAdmy+GLUsuF07nwV0T2CkKrBs+Hw0T1pXiu5IsU5+MIiVdIWa21m+HLcYqTX9KIAK9WVnJd1u4xJJJs3GlXyBUL/+TQxpfXf0L/0cmFnzD6iAEdboCOAEXvUoAT22ZWJ36x7w/kdZ5/LFZ/2OJPbJEGbyZ7a2xJcAk9Js88Tylzzu5DbETQ4m4Ai39pxRb+Lh9MqsyPVUOCgX2X2smHD9+MQ2n9xNn2GVn0xiRm1rEpitmgocri6tyS/Lv/zA/Ug+O6wmtHs49hAGt9XouEz/FHTAab8w9H8jMwcBtyF24qMmTAimAn0HC2A67iLyuzezigpD+B806unrUlyR74jZAOZIFS29RN6/IQM6W7JUrkJDLVzRANxI8lrU6h1vzmpV50rGsa2GgNqnSE4/INg9KRxaNWsgtCoXi+zHiaVb4fFk6sz/VKSVDA53Pv+Qkr9TU6qm/eB8EWqzc6DIzGL6u1pTB2BZjGxGeuDhxL7jvfjxpa3lb4VW5DNryGAgic4L/Nu+S1FEQhEL2aqupr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(66556008)(4744005)(186003)(83380400001)(2906002)(8676002)(6666004)(26005)(44832011)(6486002)(66946007)(53546011)(2616005)(66476007)(956004)(86362001)(316002)(31686004)(16576012)(966005)(5660300002)(31696002)(508600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhUbHBoYncwNmVPTUdGMkhQNGJVUlhKaStZbjFoR1BpWXBKQld3UjE2bElN?=
 =?utf-8?B?VVJseTgzRnB5bGtrcFkzbnV3a3p3VDlHdm9TTkp6ZEF1d3hnb1owQmR0NWZJ?=
 =?utf-8?B?YVBiVTE5YkEvY1pBbjNJS3EwS1VqSlJVRkdFUDY5aTFsWUVBcElRaGg2NVBH?=
 =?utf-8?B?ZllIWWN3T0kvSlFHbldQTWU2N08xUTAxWm1LL2hhTzY0Q2hPc3ZWS3FsVWtJ?=
 =?utf-8?B?Zlh0ZEgzMFJ0U3pSYUVoVXN2ek8zRDNmNm4yMWpYL1ZRSmRxcklObFlwTUpM?=
 =?utf-8?B?SGdGZ1diZFEyUFZYWmhVQ1ROcjV0bHd5SCsrL2VNUFNiNnREelB2M2xZY09V?=
 =?utf-8?B?alZ0N1JBQmNnQ3N5KzZLa1VueGZ1SHY5RGtaOXlKcGNEdTJ3aGRMRUtUbktD?=
 =?utf-8?B?YWNNNDhzQU5PME0vcUdpRDVNYWppVUd2NkdIUE0rdElCM28vUjZTWEI3QXhk?=
 =?utf-8?B?SzJWQ2FLYVhjaElVb2RMaFlyUllmZyttL2JhK1J4ekFMWTBzYVgyazBGbTFv?=
 =?utf-8?B?KzZ6T2JSUWpHazdHY0ZYZDVBYmZiNlBJMm1rN0VYSkpYaGd0RXc1ZFdQLzhu?=
 =?utf-8?B?aEFrek5EcmZ6REdDKzZSU3pmUWZpeW1NNzBwK0c1RzlaeVkyZ3FCTWFFU0JQ?=
 =?utf-8?B?ajllUjJLZThFMHdzS0FzcWR6dkdlQXBjSjQrMVcrY2g2SFJWZUN0VDhTQndR?=
 =?utf-8?B?MUdSOGFtNDBjMnJUU2VTWnVqMEdhMVpLMEt5Sm1LSkJ1TFJYaXhSL1h3bDJ5?=
 =?utf-8?B?eWZFMUJsODhnQ0lPVzVnZGJWaDZ2YnNJekNGRW9uM01NdFBXdStQdnJmU0VT?=
 =?utf-8?B?dkw5SnRFMkI2TGVKMWxyUXpDaHo2dkc0emh1eGN1VklibVRKSWxTUHh3cHdm?=
 =?utf-8?B?SVAvRkYzcHBWa2lVZWE0RFlDeTVFU3ppS09Sd1RGeFc5eEt1cXNUWk9hOFhz?=
 =?utf-8?B?cVkrZ3lEUWY5bTRoTFFqY0RwRGYwN0NqakFsTlByWGs0cXY1YStXWjEwaXht?=
 =?utf-8?B?NGxzRGd5Q2w5OEFQT3AxeWZPVXd6NTh1cWtMRkRUN0RmdmlGcDg4eUUzNGwv?=
 =?utf-8?B?K2Flc2pDN0pEcFVnUkhiRTBvejBaOFZ5OFQyMnB1cXBIaDVGUCs5MGp5ZVV4?=
 =?utf-8?B?TlBiNGp3YjNPQmNxRVpocFZHNnE2VXIwVXdha1B5N1ZOSkRHd3RYYTVjcktw?=
 =?utf-8?B?RDlBWXBUVjV2MmRMMGhTclVDTDRPSXROZlA2VXdnZ1VMbWovWmltVUFsM0d2?=
 =?utf-8?B?TkJNb2tZeVBydXJGR1VjdXZpMnNmNlRkMUNpNlREUldubEJkelo1aVo3eEJ3?=
 =?utf-8?B?TnlRdWR2VnFxVlR3bmhTYXNKWDBvZlVvZE9ONVZwUkMyY3pWL2dTdkdnMHdY?=
 =?utf-8?B?dFBDSDFSWVFGMWNaaHg4NDZpMHN6RUxnOUVqRHl3b2hEVnAxQ3RGcFAyWk1M?=
 =?utf-8?B?T1ZXNFZvU0NpQ29BOXAyTzJiQkhxYUVZd0MxbWlpYm9YZnFPR085b0pQbmhv?=
 =?utf-8?B?QjVqbVdmRUhLMDNtT3Y2eWRuZ2NOWTFwcDBDZmkwdjMwS3o5NzRKWlE0QStl?=
 =?utf-8?B?WVdCQkRSM29jdlo4MFZ4UmV4Wm5CVFJ4RVh0YUIveWgzMUpYL0RlZFhEaUN0?=
 =?utf-8?B?L0pleTNTQkIvT0JEcmMyMWo4L0dvSy9ISVAvbm51dUpuaFpIRGk0bWdpb3pN?=
 =?utf-8?B?bDlLaWNZTXFZZk9Dam5NNU1pSHkvSWcxb0V1d0Frb0RoUGp2VGJWNloxTnJT?=
 =?utf-8?Q?EMKV6b413IiwxKNs+xTCDKzq0yMYfxA0/ZyBH+D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04e6c59-86d7-446f-f12b-08d96a7e3b46
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2021 23:47:44.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kd0bSfFixALSYJNj9xvx36t7Jjh3aF5e960i0WvKLAoX0CC43eCLubTQnA8sNwpT9QU32/uT4boFfGJtEEzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3982
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10090 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108280168
X-Proofpoint-GUID: WzOuJzUOYg83hX-hu9nxmpm9_dRfMqQe
X-Proofpoint-ORIG-GUID: WzOuJzUOYg83hX-hu9nxmpm9_dRfMqQe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/08/2021 19:58, Jingyun He wrote:
> Hello, all
> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
> btrfs to store the files.
> 
> When the device is almost full, it needs about 5 mins to mount the device.
> 
> Is it normal? is there any mount option that I can use to reduce the mount time?
> 


  We need to figure out the function taking a longer time (maybe it is
  read-block-groups). I have similar reports on the non zoned device
  as well (with a few TB full of data). But there is no good data yet
  to analyse.

  Could you please collect the trace data from the ftracegraph
  from here [1] (It needs trace-cmd).

  [1] https://github.com/asj/btrfstrace.git

  Run it as in the example below:

  umount /btrfs;

  ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"

  cat /tmp/ftracegraph.out


Thanks, Anand



> Thank you.
> 

