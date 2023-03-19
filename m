Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E906BFF2D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Mar 2023 03:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCSC7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Mar 2023 22:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCSC7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Mar 2023 22:59:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5319C75
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 19:59:07 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32J2umBo010889;
        Sun, 19 Mar 2023 02:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8J1QogQhLT7cbCQyUwxBxd91kqS7tuHmfNzaFJ9S8vo=;
 b=FRxPKQqpdQKxtSt95qc6XfKRTMdK+2Opw6j/oVpQa3QuouLqlj+v45nD7Hm41pW2iI48
 zBXoT8H1lBFn5ZsqPmoQSamBmTsYSEamTdKFgceP3NnvjedadEBPNRoDeCaoZQ04J9Sy
 27+A90MVxex0zqmJ6RUmvc0koGwar68DTn0g6tU51m7LrxrWgCPuK6wBW3/eDfWy9SF3
 Ji0UeWvjJN2mFCAR7Q8U61MI8xC3vJn7xNZtfysCoXFusV8+6G0LE/GvjtjHNw2+IDfr
 suVOONtReGPcyrP1ShahX8QtBlOusPRiLWMnBQD49qhK7HFRC1HbvHF3/2X/Qiyeb4Ma Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47th7eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Mar 2023 02:59:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32INaTuq006766;
        Sun, 19 Mar 2023 02:59:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r2v0p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Mar 2023 02:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avp35iJUkqfYLhtRbpuuVOHJVCf/rI9ygBeHVjWGQOSwvzBjGySXt+3LEvPCyCSFUUv0VrmLnwXHi3a1bmlHjujTcRfcJQ28DPsVlZ0JKaUs3NgG6Zosi3NT/r6En17tIcoG9tHF4NdjkGI98XbicT0YJYoQRZMAHfD70ldNz0sYfistPcwSMGE7O4fg2c54KmQdo6rkkN9D2ia7W0jOHJGFckzFWGGUaO2IXsFYqnVa5fPcfTgAiPyaBW3KGbI/P5uQl03PrAYH2dIzEHSSc5hX1RCjQ8H1mdfXCb/1jZfwml3YUmTepgVqtZZYnAcF+MdxH5LnNlocZPJEI5BOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J1QogQhLT7cbCQyUwxBxd91kqS7tuHmfNzaFJ9S8vo=;
 b=BNx02NgIFdpPNenxQfAGQ1s+DU33LbXmvf4FDlXcmp4iW9UZsyQJstfVCcCJlmQC1CgbU8fQxGPO1Jtw8a8/ghpWMftv/oTNinTzYjdDJquecChuK3eRcBlA07kanZmyin+0yN7qHK5JfS+/TUy4ZRRelY5U7c/VXHKHhU6sHTygJdPe7hPhS4i22EPhwthYZ2xmwGRr6wATXwFuQCeDzzOQwln5uFQfki3Zr3gzUPHuFKC+Y+HHCyAWGNrnMvg85S7nmh9Jh8MaAEA/bwDqTNto4CGgmOI+Ek7F+xVeLNllf98Wm7Vcg4AZCTRq7WRaHRgA8IvuTohAhNw4sa9ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J1QogQhLT7cbCQyUwxBxd91kqS7tuHmfNzaFJ9S8vo=;
 b=qaspGYesmIPYERqAyTgNcfGHRTKI6FiTe7F/6ZLNE0vSVPuHSCNDCPzWiVe8IdE+yyAlOF/qc+KKxsnEHmG03QagOZrzEIdxodvXgdijjKgCk95HU54aT+z/Hde9fhEIhKSEvk3/ostLOYzkPtXdkw2UZqia9xm1tMFeutBAS+U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sun, 19 Mar
 2023 02:59:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.036; Sun, 19 Mar 2023
 02:59:00 +0000
Message-ID: <d0ad0411-b5db-1c06-7f3e-56bc9322c693@oracle.com>
Date:   Sun, 19 Mar 2023 10:58:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs-progs: use alloc_dummy_extent_buffer() for
 temporaray super block
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <80b02fbfe6796c85322244f2e3110295787df3a6.1679098721.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <80b02fbfe6796c85322244f2e3110295787df3a6.1679098721.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: a1403a42-029d-4658-7497-08db2825e349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddBhYDmMFJO3VgcywHxBSUWOISIRmg4JsO5irFVt3NQADJZ3dIl0E9S1nuNOZfWg/o4b6TWtV9gnKVpJiSkTb2i7Wh5pRZhPMSH7VYIYvIoPgckTX/d8TtmlPjgv3IHz3G50UKRZ7YrrtBmTOowZFtfzsPJJ8Owo994ZnjY7RiAo/6xeouA9tlp+gZ63zSY0vjNcyq11kYENcX9m7gTe/aloBj+V1VWcJ3rhDNSPkrMSdU74mE1ae3tjGbO0sfEArtADgGpY6Azhaz7+kpDTNSjbBero1XxH59Fy/+TXF4zOjLRiW6hKNM224zIIT8pQ9oTKbsb+x06962boGQx474LskHiz4mL4wpT3qb+A6eSdzZE9d8GpE77rib3qnrXpRFm8nrv1+P5Bp5uVIRWK+mccjIr1kG935QCCxquKmvRj38vlmBOTDkSr8DDE2G50445J4oprj3S47JO2mVpUBXe1plqSKh178sEW+n/j6GgItwVawaeYH8+G9433ajcJpKqG84PUkhUZ9TpWMPcT3GdZ3Ex+Pto8A0wi561hP4wdu64cBnrP7CNkwD6A8NCqe+jr6QeONEPqopUUpS2dOdDABVUPtAfxNhWfqbtfPaBS4QT9nzhaTfpdOn5uCbZ95XKrc3jc/IiMFRc9PfURmFs0USeTtwUsPQKmX24sDkTrD+M22CJBUarja9IRpJWQTFpQfmVNMSg4LXWtqHR3DcqOpxNv2uIbgam/eWSzzPYl6r5NM+TPKwvYGykewcnKPFagh/8lKDJ1A6s9fGR8NvGFChcggwJ+j7DkpjW6Fsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(41300700001)(2906002)(44832011)(31686004)(26005)(53546011)(66556008)(8936002)(31696002)(66946007)(5660300002)(36756003)(66476007)(86362001)(8676002)(6486002)(478600001)(316002)(6506007)(6512007)(83380400001)(186003)(2616005)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdRNkRVMlg1c1hMOW9qYlhNYUdXTGN0TTQwTnpxMzlxR2lTUEFWcTRQa3Jn?=
 =?utf-8?B?Q1FIbVdtNVpVdGgyVXg2OWJUUUhjZEV3LzZEeGlTR1BHUGpVS2RvYllhZXZj?=
 =?utf-8?B?a1hXVmJRcHUrWXZGNUpNQVVZaUJUR0dkY3FxSjBvNmtGMFNTREdoRGtQeFhs?=
 =?utf-8?B?TnFyTTlMZTdDbHY4KytTUVZvU0R2WXphZ3V1c3pWQTNQUXVNWXVEM3R5dnpi?=
 =?utf-8?B?djdNelJROElpanE4SjE3SCtPSW1kSVk0cEVLbHdNNWVGL1d5T01HbENEQWRO?=
 =?utf-8?B?UllqZWV3OUxmS3A2VVdmMEl4eHdTeUJ6WDRLZGFmRE5ZbjZTM3IrOTE4ckVW?=
 =?utf-8?B?cDJoNTVqRXhkTjdqQUliblZJbjdsei9RRmt2ZWE2aTBQSUQ2UjhlRGtPbDR5?=
 =?utf-8?B?MkI2eENFQUJNQjZvdGpHN3poLyticnV3S3ErcnhUVEQrZ281NUo0ZGxNYWtm?=
 =?utf-8?B?T1A2eGZ3Unk1VFQ1V0YxLzhYQVJJZExGd29sZ01IQUJVRW94MWVsc0lvWlBZ?=
 =?utf-8?B?RmZaRWFieDNyUzcrSyt5RW5uMVQ2bjhHN0V2WCtQeHRVWlB0Uk5COWxaN1Fp?=
 =?utf-8?B?ZHBwM3dwS0Rub21pOWp5cEVBM0FJSVNpOGFCMW83cVhNMzFwVjU3THRxYnJL?=
 =?utf-8?B?MnBJMFlCV1p0Q0VZMGs5VkxIMU1ZSHE1NlYrNmg0bWY1VHlDK3FKb214eUo5?=
 =?utf-8?B?YWtHMTVtWFFKUTlxM1lYQlFTWTNYUktsRFhLb2RvNHdQNUxaRWlMMUI3QTk0?=
 =?utf-8?B?d1pHWWdPM2VER3NTNXQ0MnozcWx0S2thckx5Wml4bkdHZ3hiclJLSmVlRUZR?=
 =?utf-8?B?VmZUclhCMmU2dHBzdEJlQ25RNnJvYlJlbVRLVEVjdVcyd0JKSU56WDU4U1p0?=
 =?utf-8?B?NTRQK1BRNmpwQjdPamw2MWtUSlNaT1N1MEZMakdpcEgwVDFUY3FKZElSWExj?=
 =?utf-8?B?V2VlUW9NcUl1SGJhcXNBd3ZYMi9aUjV4R2MvTFlzWUlVNFR1M3VuTENHZUgy?=
 =?utf-8?B?TnBnRkduZzhzc2NHamZGQnBWY09OUk5DSEEzVnN3L1VSc3g2RjZvQnJQRGcv?=
 =?utf-8?B?QW4zd0pzanQxc0tpc3BERUVJZ1A1ckRYVFFydWFXMEl3d0VPaGhudjNPS0F5?=
 =?utf-8?B?TzB1eUlsWklmaDhrLzFyaldzamxZZ215K3pjYWg0UHlma1RoZTNxN3lTallI?=
 =?utf-8?B?VmlGVGt6Q0wvQ1ZoMjZwdG5GalpVeUw3YUpSQi9RaVYweFpIMVZOTDhlb2Qr?=
 =?utf-8?B?RGEzdzNIMCtQd1hoalBiUWxrRGFjWWxtVittNDB4VURZK2VBZkxsZDBQSDhp?=
 =?utf-8?B?NkNCUWFiM2ZPeXhwOE9IWFJCVlVCY04yQVB3UUM5dTJXY01RVE9rcHNKaHU5?=
 =?utf-8?B?VjJjUjQ2RXNSM1k5eFcvTkczMGVpdFpOSEpHdE9INDZmRDBmY1pHeThFc1dL?=
 =?utf-8?B?Yy9sTWd1TjlSSUhOTWllNnE5dG9BS1RDcVRWTXl0WWZ6NnVoV2JtRmRySVBB?=
 =?utf-8?B?aUlqc0dlUXE0emNIY0Z1UkRVTzNYbWJjbjF2d1JmVnYwVmNIcUJ1eTUvaTlF?=
 =?utf-8?B?RHFVdVNlSmQrLzdDL0x5cWF5cG9RckFSS1NJZVRWVEpvTmZSalJmMG9CZUVa?=
 =?utf-8?B?RXJvUnpvbDE0QTVQUWc4N21sVXBSTlhXc1l2b01PQlB6TFM5NmV2SlJJUGJC?=
 =?utf-8?B?Ukt2YjhUNnF5V0ZwU3hHbXdoclZLNDg3WmxyRUlOdkpMYUd6UU8vWXQ1d3NK?=
 =?utf-8?B?QzR4WjErWExIYXRjY2NiS3VZc0RlcFdpQUdJcGE3VWVjNHFBN3BPTC92UzB2?=
 =?utf-8?B?R1FLdHFUYjFnN1d2UlhtZDRMMFpHVG0xb0JCaXlySUs2QU03YUorSmJZWmpB?=
 =?utf-8?B?RlpKem0yeEY5cXluZXRRUEQ5M0pRdTlKUGlDVnB4MENna2lHdkd1NDBIUUNa?=
 =?utf-8?B?ZFJXc281SHc5WklGR2dlejNqU2daenNsYlZiNzhjVUlkY0ZrMUJrOTloZllI?=
 =?utf-8?B?R3JVYnVWSWJLdWFQUFN3VkcrcE01S1RjU3JweGRJSmVlb29MdlVNTTVUWjlP?=
 =?utf-8?B?Rm5XSDdwZ0FxR2RCN0JSV2hDSENwek14U3RocTdmU0dnOXFYY3p2U0kvKzMw?=
 =?utf-8?Q?Wru8q5hsrVAXUigwf15gtBeyI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n1MQPAx/lHMj4jEPU8UFsSG90RzlZEYr+sJuzC6jUl7UPIrfpLsjuC9/+pw9J+ZN1jREoHnRpmAUzHQvabF4w5iERq/shgFwdfUIeExcvdxwUB9S33NmK3Pyk4jR0r+xCz62cLpxAz6e8dK0W5aU0bN3qm+UQWboOdTVBwCimPZsJLIEMiTbBPcfpxANv7B6GTYmvSoUeLbKiBo5hkcG56lpGruUGffzeefB2UQDhvCW5iEZFnqvFJSZQO36hoiXSamp+TQHCH1UiO21KXnH1OXB1kUzEKxzY3YwMyMDl7Os6f9W/1PF9pWwCo347smc0WLzRW4q0Q2OHuVpxh/GbG4A2lUsoXz3HydF07C7sV8HJ3zO9qtEe6y8dGVUyRcVJ1vedVttYJUL5uG0vp6egwh9NVE/6h/1t/2WrFd9dNUXWUr4DlrAgo7jGWXu69hUnYEb9NVecFNsCfsS8bIagnvQ0M5qy9qQE6Ro6g/C+i6jaBe0o8z2im+OLwMIcH8OLLK3oRtg1mlV9QUl2uHbXEFORfxL8xSEbKE+fjPk3DtOyCyZJLf1Up5Se+m/ZAkqkboq/YvwcHzjw401SOCAF10+rVYKc5n2P5MCVbNjlnu/HCf3ICQ4/7juf6IHgp7f9HHZEJz/3uEd3PGPWth4zsXZxDNPZIO/SVMbkRck9NBWGWkkjtDX4+0PXA7qVqMoPqeRo5aJvLlcglDR3axFLnNNOtndNTTYJK+EgQ5xA1WFCsAuzCcXi48ZgWAY2s86xBaD5wD4rwdz9+86MMCFkUP62DlfL0XlZexiyC/WNJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1403a42-029d-4658-7497-08db2825e349
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 02:58:59.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiwP5qpqh210YPU38WiM5Z2S5bdgNt76ReZyYmS5cH60qgDR8kCBQYzZ7Hsn4vXrGC0EYHWPYBv1a39otUXXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303190023
X-Proofpoint-GUID: ZmJ5lSd6kNi9MurpDC6axtXbsuDbxDSo
X-Proofpoint-ORIG-GUID: ZmJ5lSd6kNi9MurpDC6axtXbsuDbxDSo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/18/23 08:18, Qu Wenruo wrote:
> [FALSE ALERT]
> There is a false alert when compiling btrfs-progs using gcc 12.2.1:
> 
>   $ make D=1
>   kernel-shared/print-tree.c: In function 'print_sys_chunk_array':
>   kernel-shared/print-tree.c:1797:9: warning: 'buf' may be used uninitialized [-Wmaybe-uninitialized]
>    1797 |         write_extent_buffer(buf, sb, 0, sizeof(*sb));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   In file included from ./kernel-shared/ctree.h:27,
>                    from kernel-shared/print-tree.c:24:
>   ./kernel-shared/extent_io.h:148:6: note: by argument 1 of type 'const struct extent_buffer *' to 'write_extent_buffer' declared here
>     148 | void write_extent_buffer(const struct extent_buffer *eb, const void *src,
>         |      ^~~~~~~~~~~~~~~~~~~
> 
> [CAUSE]
> This is a false alert, the uninitialized part of buf will not be
> utilized at all during write_extent_buffer().
> 
> [FIX]
> Instead of allocating such adhoc buf, go a more formal way by calling
> alloc_dummy_extent_buffer(), which would properly setting all the
> members.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



