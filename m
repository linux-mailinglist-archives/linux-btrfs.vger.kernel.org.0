Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB359913F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 01:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiHRXhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 19:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbiHRXg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 19:36:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34857DB066
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 16:36:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27INYeqY010437;
        Thu, 18 Aug 2022 23:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KXMOA1ZCk1KPhfNDnaQO+P/pHKyDJq6hopFOfDFw0VU=;
 b=UH95r4ELklC5h2z6SkzXMshBBBUsZzWLCgwD1L4x930JIb2QUfM7y9jIY1SHfcWlWmR2
 v5mgJRnC6AHDgcdDR2cGc2Fa2dZ9P24qmudqNKzx2sxeNW6wBS2CHy/xrS0VbHqTQd8f
 Cm4/i3vqsOguYqXhIgjOy33u6VlLUZJOEDeMD891LsdzTabK0IrV38+8F+xcj7o+3AVX
 LlmSwlGf7g3L2NFpWOPmG+9m7mFP33wsxeuAHtDUPoIQ9Hs9NGOLrxN+RaTc/WxbAW8B
 /68NuSoTS3ltpseCzAq2ESk/DB16J1//5qO5NJDEhc4n5pfMZGgAASqxnrOZMN766QnW cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1y7g002k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 23:36:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IKUXu0009947;
        Thu, 18 Aug 2022 23:36:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c2chb71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 23:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY1huadFL8lV6f370nh0Gvqy04bYxFauKFJpPL1gJM2VZdiCSgfEOhM4f9ypyFQRX52RFnmwLD5rJVmXdiDR7i2DJa/c9wJdbsCuIrMCRWpozAhs10prVojK+RobS+U5s6sO/K04OzSybMm0wnjEO4R3Ew9JbZtBG1T3RLbvQuebqXW62lS8fmdpQYnP1v6REoiNyZWB29+0HXoCCZqh5/xVHqos85VyUjHNtQ5YoX/4rsavucie2eQVh8DcgsR5xgene9P7vZdeju0msMkGFdNtlO/U/01sw15vMrhZsEOPb88HYJA2SxuqhNtWFLJF57qGySdL75uT+CDZOgHh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXMOA1ZCk1KPhfNDnaQO+P/pHKyDJq6hopFOfDFw0VU=;
 b=gPkhDbtGYsXRpj4uohC6gDY6gE7OAhqnSqr1IuaUcFbKCa2gnXZxq3j5TuE2Gn+6O1MeJd8pVLH4N8v+6OvYOnwBIwMN1mdQw4bO+TF/ggrQDNNSioY7toZYrfZYWki66H+FXmLY8zrwEDgqK47k9fPYw7ejBTxIqgrrFInYACofkaLz9gXuGcxVph2N/9wOCjSmuHT/GLKBfbfnXDE/r99NovbLSL89oWKu5PTPYwbzKkYNTx3RVyp3BLlrH/p4WpXgvrjBXkus2IfqG/VlhuBuzNnsNpqf1WHpoj2yn7nLWbDbq7PQNOBcvUEkBRWMg8g4K/e2XCPc2BRTlsQh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXMOA1ZCk1KPhfNDnaQO+P/pHKyDJq6hopFOfDFw0VU=;
 b=Ysvdy3+xFoLmNHnIYMJCvpDT2fvmDqGDEDu5VDCiWasYuwGCdgIQXtF5UP6RLdN7Fr+GpycuGfIFqBgVFHF06UYccGEEyLknnLa/i66+5wxXpuujbiJ4Z0KgPANZBCoSdba7Er2MZAq1/CkuPSk41putpwJntWuMmO7jWS4u7Qs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN8PR10MB3476.namprd10.prod.outlook.com (2603:10b6:408:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 23:36:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 23:36:45 +0000
Message-ID: <8b63c037-d424-2ad6-7545-93ce8e099762@oracle.com>
Date:   Fri, 19 Aug 2022 07:36:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
From:   Anand Jain <anand.jain@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-6-hch@lst.de>
 <59dd66aa-8917-5dab-f368-61294ff3f0cb@oracle.com>
In-Reply-To: <59dd66aa-8917-5dab-f368-61294ff3f0cb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f200d4a9-a185-496e-4ef4-08da817282ce
X-MS-TrafficTypeDiagnostic: BN8PR10MB3476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw3dNMnWyx5EQdjBggosNJxqKWRZ3DC1oW4v1AYTwdQ/eS6bkEO3tLLAUxWW3Tjcx8FDjgtVZuc5+VDHXjaygTyDtms/wxsLkqIu6GqhWT9iMFYf4veiHJL4RgQOFzc20qCI17K2iu2vJZxBG4Mv5ERDR9+m1Rpmw+wMGaTWNZQmIADw9p4USD8pWhmYZmMn1VkVrSnlXYSU4Kr/r6iH7SUc4EHFHWWmhXIpCVWVQw/g9bsg1bHkxryK0LE581Mt8ZEyvBhlwb4WWnU2BT2QYHIkQxTEY6Lg5Quii39I87v5A4B2MrXkLy44uIxtO0dO5mSf/pyjtdsgPQayHlmoEqh4xX8z+S34KUdom93LSttzmx7EgqTX7znm0yKIAIBNxl1U5mNl284wjiw4KMxvhFKe3LqKp/vA0KxiDC4e/lqr79BRsUAlG0Qjqs2pG7gA+HAK9gnWpLb7mh8uqqWiIAYqe8icNK8WlQYQIU4/I3S5+i4B09i4vIn5iLbo9ZUghNcQFXbXjCvKf9gnoXBPv6qk6LZV9GoQ9Xs59dsL9x+tssG2LNLarSi4FcGD+PduetgK+pSHwadT/i+CvZbKQqGvnDGZtFYKNUWv/c31FUtJm+Syb9XFW9QxhXf4icViY6XmlFLd/3mJHjLlg32SUaTn+6LAdmXbwz/tPIxAIxn+tVP8C7nmH5cg759K+rerp/iziEu9JbeJH+/IuisjIbXFVQ7Xp5PpvnlLeMMZo0RYPcq/jTQ/D5eItocbF89/hSeE3t1jOwNMP53KFxgJtLS1dfkzsn9rxUss+F2KLyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39860400002)(66476007)(8676002)(4326008)(66946007)(5660300002)(6916009)(316002)(66556008)(54906003)(38100700002)(8936002)(44832011)(2616005)(2906002)(36756003)(86362001)(41300700001)(26005)(6666004)(6506007)(83380400001)(31696002)(53546011)(6512007)(478600001)(6486002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVYcW9tcHNBM20vOXZsMkFWSWZkUHpFUmF3Wld5cVc0R29hQXZQOHJhZUJ4?=
 =?utf-8?B?QWtPV2daczhaemlzV09ydjJvaGNadFgyVVFsOHljQzFLcFNtRGo0c3VGdG0v?=
 =?utf-8?B?d25lV0ppWjdTVk9MaVVJMldMY24zNENmK2hMK3l4dTd5MU10S3AzTFdaYkZK?=
 =?utf-8?B?U0NMWHdaamU5ZHl1QzdJQTgrd0dVbmMwTDdWSjFGUEs4a24wMGJERjBVeVd6?=
 =?utf-8?B?VllIeXpqZmV2bXEzTCt1SEgwQk84V1NXcysraEk4QUt0QW9sOGZCWkVoTGk4?=
 =?utf-8?B?YTc0ZXFuckgwbUZpZHZ3enJpNFpzZlBaaENoOTVjV3diekVkTXc5MVRBVGI4?=
 =?utf-8?B?bWNyYUVNbkhzVGF3NkxGL2Q5WXZzUitURi9HQytiaVZmdStYWjFsSFR1YXB2?=
 =?utf-8?B?ZGxkVlB1bkIwcHB3djVjMzc4QlJvcmd6K2Y3NEkxMUoyWmExSUM5azQ4bmhl?=
 =?utf-8?B?OEZqa1ljVnQxWGowREJQdlovSHA3QXNjRU5MWk00STZqSWlhbWs3ajdJaXJR?=
 =?utf-8?B?Q3YxWjB4SlB6Z1d5QWpGNEpRWXFodXpWaVhIUGU0aURINnN1TnVUY2ZjeG5J?=
 =?utf-8?B?cnh2bWM3dlNtR0QxYWpla25PazRWQjIveTZWMU9XWkpFN0k5ZmVLOXVtb1dq?=
 =?utf-8?B?Q2xzZmZjRThPUnNOWHQzQlp1SGg1NENzQkxQUGxIZ1NqemdUdXBRL1pQRkk0?=
 =?utf-8?B?VExvM0pQWTNqdlF4a0JMZTkxVGRRWGRreTZlaDZ1NWJacGVrWjVndTA5eUJQ?=
 =?utf-8?B?OW5XYmViRktIWGZRODVvQjRFOWpXS0pQclU1cC9nbEkyQktScmhUTFBQMjRU?=
 =?utf-8?B?L2FMSnV2SnI1Qk1TUmFGRFFrTXRQYW1Jc2N2eFlTa3VqV2VNcUZsN1lmTmVU?=
 =?utf-8?B?Mnl3d3Z2WDRjKzQrTGNiVHJWR3hOb0lCMFR2NU9KUElYN3U2SDUvNGRubjRV?=
 =?utf-8?B?STlJNWVCeTkvUDlYbU0yYmlNQ29yRk9hQTd5QUg4bEQxT29lR0xEN0ZDVzlm?=
 =?utf-8?B?czBIbWZ4Y3BjN3UrZnNONUFMMjc2SFhmc0tPdGlsejZCUHZONWRFOVZWaFRi?=
 =?utf-8?B?QUE4bmJ3WHJScXJGTW1ud0NuVGZkaUVyc01zU2FwTmtJVzZQaWJsYnRxUnJD?=
 =?utf-8?B?Zi84V3BFYWJVQzJJcStIQ0NtVDJuVmREMzE4Qk91WmsyaFdCem1XbG9tM1Qz?=
 =?utf-8?B?WVVFY09tZUcvcFlJa1I5Y1NYT3ZqaVpLUzI5c09YKzZaUW1VOHZHeWZUVlRP?=
 =?utf-8?B?alJnM1NtM1FPSHpIeEdpalVBd0QxbmlBa1F2SUtGTzIxVC84RFBOTmo5WXV6?=
 =?utf-8?B?V25vcm5kUmlhTHpaK00yVTR0Skd0Ry93bTlxYWU2dnd6ZHdTWEgwUmdVVXFY?=
 =?utf-8?B?Y01wMmd2N3FnSTIvbFNhZ3RBOHhoNFhpaURCR2xSLzY0d09sazlkTk9LRW0r?=
 =?utf-8?B?MnlLUU95VGl4VkwzaHNzbTdKRUMxd3hoNHUrVmM5S3MxWncrYXBmd3VISTNj?=
 =?utf-8?B?Mlh1M1FHVDVlRWJjckhFb2VYemc5QUN4b0c5S2RTajd5UzNlVGxFRnBFVE4y?=
 =?utf-8?B?M1NQTjVaTTlTa0pOY0h3MjZoVXc0N2ZUL1duTS8rdjNNa2I5Ylp3S0JPd215?=
 =?utf-8?B?Qm1OZitjRHVRM1k2eXErbHpyUHI0eWNEbDVYY3BDZGhVdStKV3dBRm00UDgw?=
 =?utf-8?B?VVdWLzczbFZWeEtCdHNvT0l3eGd6TVFneGRjUVdWa01McHI2S080YUh4NVpU?=
 =?utf-8?B?TnFKVEdhZVQzYUJTN2RNTm5KUDF0NlRmbFBXWTNUeVVpOUlBUnk1NW5KaExL?=
 =?utf-8?B?YnhXVm82WUdFRjZveERCQ2Z2NVpRYmF6YWxpeHlUTXQvK25WT1BsWHdzNWZR?=
 =?utf-8?B?em5GckIyckVWbjNlWDRaTUI4ang3TTFDZEp6VGU3TTkrbGNWTkkrcHR0eS9T?=
 =?utf-8?B?RVZFTllITGNBT0oyK2hBSGpoRmhzMUpLRTJRSDV2Vk85cEV3anVOZUlnc0cw?=
 =?utf-8?B?WTY4MXRhc3RLTkdJUGEwS214SU5ZdFEzZVdlU2xmLy80bm5Bd1QrUmwyZHRl?=
 =?utf-8?B?NUNkaGU2M3JDMGRLV0kvRWFmdURRUDlpZTR4VEVpZHpwVzkydG5maUV3RnJU?=
 =?utf-8?Q?oWI5esrkhKoKxxdbxdYzLQX6H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q2thRkUySFVlVU1LYkNEUWxnNHZCSkNDeWNoVlM2eExlZ0w1S3lzOTUyMG9L?=
 =?utf-8?B?Z3JKeFNTcXVMSTlYRy9hUHlaaXJ2Nm5vS3pkWEtIWU0xWmM5MUs1aEplNE1R?=
 =?utf-8?B?K3ZsYkVSQlhIWDFMdTkzeGYzYk9jQlh2MkRieTIwZEgvaFIzdFlmWk5WUWlD?=
 =?utf-8?B?MWxjS1U5MUtEcUtwcmVhUjBnZll2djJoZndjRDdZZzVxSE9GdGhUS3B5VjRq?=
 =?utf-8?B?MEpMczI0RFBPbUN2T2lXR3QySkdhZzRCWUs1ZHpvZ3hPdkpCTmp6WVVTUnls?=
 =?utf-8?B?a1J0Q3FmMmNNMFBGNzZzM2VES2lzTE00bVpjaTE0MUFEeTd6WlREREUwbmRJ?=
 =?utf-8?B?ek0rRHUwVG1HTkFRY2NyZUpvTEhJSUFEZ3E5UVJ5WG1BVUEwUzNrNVQyMWtk?=
 =?utf-8?B?Sk05cGZPNWNkbm5JdUthaE1tVFdMeVlwRzZ1WHRheUROT2FsZjF5amxKY3Bi?=
 =?utf-8?B?UUlrOUZqTGdGN2ozZmFZMVJxakdZOWM2TDlQbUh6OWZVdXBrSEZEbDZzZXVH?=
 =?utf-8?B?NW1aaWZud1l1MjFRRG90RUNUVm56bmU4bDBDZURMY0I5QkJrbEE2UEsxYU91?=
 =?utf-8?B?bFR1YzlxMng4TzVjUDdJRG5BZkpJYWRmYU92Nnl1bTRMK1YzUVFSOG1VUmdW?=
 =?utf-8?B?NnpTUWE4Qk1oZW9ucUsrZXd6MEVUUFpIanR1dklScG9qOTZtWWVxY2hhVWgy?=
 =?utf-8?B?V3RRVllLRjJlZGVGdEd1bFJjQjN4NXJaL09CazZObXl4K3puMHRtTzNTTlZD?=
 =?utf-8?B?Q0QwMmxtZmdzZXdYdWJuNmtNOUl6S1l2T2pxR3E2STQ4QnV5ZVdXeEo5eVlH?=
 =?utf-8?B?QkVndjRSaGxjWG5LZ2RoRW9RMm9lQmVvZ1hFeEgrUWJwQndWcndlYWdabndF?=
 =?utf-8?B?bE9vYS9DT2Rpc1p2dStoV1FDemZBaDNHeW54TXZIZmZsaUZWVU9qYlRGTXF3?=
 =?utf-8?B?aGRLQloxRlhNZ3hUTUU1a0RjZ2dpM2xCRVVLdlAyYmM3b2w1OFRjYjNIN0VS?=
 =?utf-8?B?cTNzTGZzd1BSTTFmeDJZc3hYZklpYzZvTHcweVdRLzB0OWZsOUNOcTkzakFF?=
 =?utf-8?B?K3VKMHhuOGthU1RzQXpkUVRGekRGZGtuWnhUdWZtandRZTJ0VGd0Z3JtUlJB?=
 =?utf-8?B?Vi95ZzEzRUVRd2RxeXE5ZTh0MXF4RCs5dUt4NGF5c3Ftd2dRQk5UREhkbmZG?=
 =?utf-8?B?WWFIYWtZVDZnQXNWSVdseUNVSDEvNFpjNEpnZjJSbUFzY3VZd0lLN250d2lF?=
 =?utf-8?B?Sm50TUR6NW5ua0hweWlCYTRYNmo5Unh6NUV6NXZhVEpRRDhRaEFBdTMvUnJz?=
 =?utf-8?Q?6G/pVWkT+rt9JELR491OvWYVh7z3rmE4f6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f200d4a9-a185-496e-4ef4-08da817282ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 23:36:45.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/lnho4QJtocM+yqD4F7PpRywqWIB0nUwds9yrMnCAG6ONgueNylSdKIPEvOsOhKCjDJPIx3gwlOm2gB3xD12g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_17,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180086
X-Proofpoint-ORIG-GUID: F7-tBtJE8QkVSvPUROf9boPWZPJ6hpGj
X-Proofpoint-GUID: F7-tBtJE8QkVSvPUROf9boPWZPJ6hpGj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/18/22 19:33, Anand Jain wrote:
> On 8/6/22 16:03, Christoph Hellwig wrote:
>> The stripes_pending in the btrfs_io_context counts number of inflight
>> low-level bios for an upper btrfs_bio.  For reads this is generally
>> one as reads are never cloned, while for writes we can trivially use
>> the bio remaining mechanisms that is used for chained bios.
>>
>> To be able to make use of that mechanism, split out a separate trivial
>> end_io handler for the cloned bios that does a minimal amount of error
>> tracking and which then calls bio_endio on the original bio to transfer
>> control to that, with the remaining counter making sure it is completed
>> last.  This then allows to merge btrfs_end_bioc into the original bio
>> bi_end_io handler.  To make this all work all error handling needs to
>> happen through the bi_end_io handler, which requires a small amount
>> of reshuffling in submit_stripe_bio so that the bio is cloned already
>> by the time the suitability of the device is checked.
>>
>> This reduces the size of the btrfs_io_context and prepares splitting
>> the btrfs_bio at the stripe boundary.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   fs/btrfs/volumes.c | 94 ++++++++++++++++++++++++----------------------
>>   fs/btrfs/volumes.h |  1 -
>>   2 files changed, 50 insertions(+), 45 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 014df2e64e67b..8775f2a635919 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5892,7 +5892,6 @@ static struct btrfs_io_context 
>> *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>>           sizeof(u64) * (total_stripes),
>>           GFP_NOFS|__GFP_NOFAIL);
>> -    atomic_set(&bioc->error, 0);
>>       refcount_set(&bioc->refs, 1);
>>       bioc->fs_info = fs_info;
>> @@ -6647,7 +6646,21 @@ struct bio *btrfs_bio_clone_partial(struct bio 
>> *orig, u64 offset, u64 size)
>>       bio_trim(bio, offset >> 9, size >> 9);
>>       bbio->iter = bio->bi_iter;
>>       return bio;
>> +}
>> +
>> +static void btrfs_log_dev_io_error(struct bio *bio, struct 
>> btrfs_device *dev)
>> +{
>> +    if (!dev || !dev->bdev)
>> +        return;
>> +    if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != 
>> BLK_STS_TARGET)
>> +        return;
>> +    if (btrfs_op(bio) == BTRFS_MAP_WRITE)
>> +        btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
>> +    if (!(bio->bi_opf & REQ_RAHEAD))
>> +        btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
>> +    if (bio->bi_opf & REQ_PREFLUSH)
>> +        btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
>>   }
>>   static struct workqueue_struct *btrfs_end_io_wq(struct 
>> btrfs_io_context *bioc)
>> @@ -6665,62 +6678,54 @@ static void btrfs_end_bio_work(struct 
>> work_struct *work)
>>       bio_endio(&bbio->bio);
>>   }
>> -static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
>> +static void btrfs_end_bio(struct bio *bio)
>>   {
>> -    struct bio *orig_bio = bioc->orig_bio;
>> -    struct btrfs_bio *bbio = btrfs_bio(orig_bio);
>> +    struct btrfs_io_stripe *stripe = bio->bi_private;
>> +    struct btrfs_io_context *bioc = stripe->bioc;
>> +    struct btrfs_bio *bbio = btrfs_bio(bio);
>>       btrfs_bio_counter_dec(bioc->fs_info);
>> +    if (bio->bi_status) {
>> +        atomic_inc(&bioc->error);
>> +        btrfs_log_dev_io_error(bio, stripe->dev);
>> +    }
>> +
>>       bbio->mirror_num = bioc->mirror_num;
>> -    orig_bio->bi_private = bioc->private;
>> -    orig_bio->bi_end_io = bioc->end_io;
>> +    bio->bi_end_io = bioc->end_io;
>> +    bio->bi_private = bioc->private;
> 
> 
> 
> It looks like we are duplicating the copy of bi_end_io and bi_private 
> which can be avoided. OR I am missing something.
> 

No, it is not duplicating. Now I know what I  missed. Sorry for the noise.
