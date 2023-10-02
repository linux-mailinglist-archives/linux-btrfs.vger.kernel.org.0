Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762B7B537A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjJBMwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJBMwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 08:52:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FEAAD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 05:52:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928XSZt007412;
        Mon, 2 Oct 2023 12:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2UoBQf4Gsdbfxv7hVePKUzPJQP7eQeFIO5jK6k9VGOw=;
 b=YJ7gagkoWW3/UBQM4AdOo91a8mW0EBEuS2r6wJJ0odDs7XQTafnMU2FVWGQRlcEr33aq
 xcbyJcyZuDMq2IoZNjwKCiwJ9loAPhOljg4Vq8vpdUc4uO639NxXdDGB8TVJoyTUX+kr
 nM8m6ALZdK6fl3n3g8OQJITz0Z9NQo0jVdbm9/ew+h6zMepzmDKD3saYlTWTGKlUbBXn
 u5frwnHwj2Llo17J3bM2JLBSYxieoG61fki1Ts6vpomq4mogIzeeFRpqz+TPc5qpujF3
 QXo0n7bDgaKlsJQKLniTsvnnt3lP6LZufytv2MLOrKmCkQg4PYyvIOAjNxr7GqCkgqx9 EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf42e0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 12:52:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392AWWPq000409;
        Mon, 2 Oct 2023 12:52:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44ge3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 12:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAtR4Ll+vX3nUguNzOXRJIshLzVgkdUC/nYUj+of2zoOm4qw8tRCU/81nMoGiyvz0uX+sgeKLn0l8IWSf9UPCJIC9zN5JEM4xCRPlxTQsf3xke7QN4JClbHIe52UPJnUEOCutPh7xIGIFjMiAnPOjnvslSZljeU5smykzH/FS3UA4Dxfv+QqRQOXT40dJmpRYKJJjrBYRRG1+XUMJunBiGhctvGlQCjCXChLmZ8xSHCj9rTwLpoiaOF0x5iwitUbF//FcK/2tfYd6P5Ik+qzofD1UKqXscW7uhpS3AS+tyjtlr8rQqJot0Ni3KJPGCQP8NppBapS+AGaAI8a3KR79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UoBQf4Gsdbfxv7hVePKUzPJQP7eQeFIO5jK6k9VGOw=;
 b=ZKLIGR9QN+pljM7pyQf7zqtQgklubKKZKUDHORVxqwytXGDNfAyQxCGhTj0WZyoav+SitctZF4dU2iwY+7HhiCNaNhsonXBKpglEoCPZPDVC18q7m1FhGAsmSs8jTiX2nz1wlC5LiMg4j1C8pUiPWy/mR9kdjY5MAKdn7QF7B/46rxixTIxRC5OmC54H+KPnRnlad97gMVPx6pEtdLkEapdeagMSJPuz0sq+xx1VZaZBVNYUvWbZIaOpnErrr/SuO10ALEt8jd3tHsra8Kyj7vwR0mHSx9hxpNgqQ1jI5YfOYRBBOD7mHvWJQCkHvVFpqkSSCfPkivCboBJMJdDxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UoBQf4Gsdbfxv7hVePKUzPJQP7eQeFIO5jK6k9VGOw=;
 b=t00Gl3FKlS+yXHqoPcOSOOZBafT8aofBCG0Juz85Bpfv3751BIIhZ2M87QP59PJuxeAG0VlQDs7R4Y/G/RJB86LD546RTjI20uTnMooq6A8uZhzLBo+LRdKVBWzCW15yR90Jx6UGKNRRsGFD0AlGT3Ubd3Hv2jdca66xVD1gW1U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 12:52:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 12:52:20 +0000
Message-ID: <6b78aaa3-32bf-30cb-a6f2-1d8a4f1675b8@oracle.com>
Date:   Mon, 2 Oct 2023 20:52:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
References: <cover.1695826320.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1695826320.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: f376d7ab-7681-4d8c-511e-08dbc3466a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdjjg7moqNzz7sr9od+pumR1Z/ZqgTKlyllJoHwDP/bBnd54692pLk5NatX3JFUcwa88PbUGnIu1da4pruplolzZmNV7v0NxV/bqMDc3Sw89H6ME1SMFjy6AWG8EDS8JoAeQ8bjdbtXikiI6kKfl+HlRiFIzPji1wMG8Jj/zhgVEzAXHb2/zgbXCv76U3NV4ktFQUykVV2gQlnpWBlqKcVS6k1vtF7kkgTDn0595pJ4v7nCIA5zTdUsyxvcIapeVRNAe+JTps50uyGPuDmvpa4VOhx5UbXpnslnXeZhDNMwbYjUmAn+e6qpNvoAjeWgP57V1sWowHz+VWQEXM4fxnuVBt70L+bSzFxCx97ZbvvElI4eWvd5Z50uwRPQwdgR5uZeBlN/QXB2AGDmK5buzM99nVDwrBv5kWBuSBmBoD8rKbZLVKEwm+4zaq6kuqyQgQKGqPzlOhKcMQ4Mrc2iQk3GEQ/Tj6tVCzsBhrXgYJbIFCPgjeOtMFT55Zql6wYHwffgRzmGMvOpaLpMcfdANvsoc4UXt8Upa1+JQdZdZnvyNbS13CfAvuL0IawgE4BLCunN5duH67oC+JbIVukWxZThbSH8KNUJav2TSibCcfMQ2YlLhAmQ9eUQWFYreSLYLFNEiqIsdeFc2P7ctyR5W5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(316002)(54906003)(4326008)(44832011)(8676002)(5660300002)(6916009)(41300700001)(66476007)(66556008)(8936002)(66946007)(2906002)(31686004)(6666004)(6506007)(53546011)(6512007)(478600001)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1crdXVnUk81WGZVMXBpTzY5cFNkTkJidWJsaFhyQ1UrRGhZMTFMbk9zVHQ4?=
 =?utf-8?B?aE9HWkhXTlZpUnRZdUFTSmphaEg4NnRPUVlpendnY01Id290TXQ0K2ZSV28y?=
 =?utf-8?B?VndLOFd6T1ZhRWcwRUZPbHYvcHdnRWZNQnc4TWpIWEtabE8zRXNJTHlVbVJK?=
 =?utf-8?B?MHBCR3ZHM1RDelh2cUVBT0NWU2FWaTJReVZtRmYxajBjTUJGNEpJOGtxN083?=
 =?utf-8?B?U1ZUUUlTMmtoSkFkYnFQcENmcCtCUWVXVXl4ZzRZb3hNNm44OWdNRFM1bERv?=
 =?utf-8?B?YXlyc0FxQkhUU0VyeUVLaUlsZWhidlpvN1FyNm5IZ04zdjlBSlZUUGhzaWtx?=
 =?utf-8?B?cWlEWEZzWTVka1dmc3QyZ29jS2xQWEU0QXJqRGNNVm9tWXdmZmhCaGlsdWlv?=
 =?utf-8?B?VzQ5R3VzNTBDaUFPK0FrWXAzbjQ2T1krV0FxQ2pBNzRpYlF2MW40Q2ZKQ3Y3?=
 =?utf-8?B?cDJndlpySlpuVmNnRklJaCtxTUtSeUxuYmVRcFVzR1BUOFBJMDRrTERBQWo4?=
 =?utf-8?B?ZnZpZEJsNWFNUTE1bHZTM3A0VmhGMTFySFh5Sm9qOTdyaFdqcW80SXVzTTRQ?=
 =?utf-8?B?RGN0eHByc0pYd2hHdWpPc0tIY05UWDYxZGttV1ZiNFlzb0NzdXEwNHdyQjAw?=
 =?utf-8?B?c2lzMzNhUTJNOTJGVmFiSHQ5bnAzbjhGdDc2OUl1WTI5RTZLNmRjRDk0VTlK?=
 =?utf-8?B?cmVQSVVWQkxialFyQStWdkpYbmhxNWVhckY2STlkSFFzaU43czJSME5vZ3JY?=
 =?utf-8?B?ZnlyZ3ZQeWFZTFJrQjNKODdFeHB4ejVRYTc4bXNCTnpLenVOOUtRY2twTVh4?=
 =?utf-8?B?Rm1taWh0bjNRYUk5NWZTRVJWb2UzODc5WXdLL2FydGlDOGsreEpZWUFqV2lB?=
 =?utf-8?B?S2hvZmtsWHdITk1WZFJjeFcrWmZUK0RlYkFNSTBLdW5DUkI4TlpyUFBVYTc3?=
 =?utf-8?B?alBLdUhIbGx3MWxGdXlnbXo0OVRhaEJ1YkxjSy9sZlVkSjE3NjdnMXBEQTMv?=
 =?utf-8?B?MWFscTZ6QVBvdm5mV3pVZ3dSZWNmOE5NdjAxS3dzb1llZjZ0Zkg0V214UGxx?=
 =?utf-8?B?WHFOY0xNVGRpazNMUkVoLzZQNm1lZFd3YUF3Tm1tTkJQQ0IvMnNrUzc5a1h1?=
 =?utf-8?B?NXVkT2tNdDN2dUt4NyttbDJVZW9BWTlzTFpQM3phRWRJWHd3MVV3ZTFNQ3NT?=
 =?utf-8?B?eWM2VkNPMEwzQmN5Y3pZU1pDMkJ0bStqaHZ3QkhsQllYLzlKT1h0VnVva211?=
 =?utf-8?B?WjZoWVpTbE92b1N0eXZoaVZHM1MrL0tQUDhEU0dpcFgvTENHL2NvZzkwUTRi?=
 =?utf-8?B?Q3VCMDV3ODZSWEQrdEYvYStPdlNmeUxnSGlCbG9VVDRqSWw4dExJL21xS2hN?=
 =?utf-8?B?OU51SzNRRU5QM3ovWStCbThVSkE4b3p0RUVtOTRRcE1hdnU5bllFNW9NQ2xn?=
 =?utf-8?B?VzhqL3Irc3gvTTYvNCsvZy9rajQ5ZldVZlhpL08rY2ttR1FSZWlsOWQ1UC9v?=
 =?utf-8?B?bjRubmF2NFhLbmpkOElRam82M0VDYk1IMUhPWEtvZnQxeXBhbVRBRTFOQ0s3?=
 =?utf-8?B?TEkvd1FPMmk4L0xNWVd0YUVVbmpvbHN2MS9GMkJmejR1OEkydHpHeFBjKzFZ?=
 =?utf-8?B?UjhXL3ltS3RvL1lXdk92RVdqSnBnUmhlQXA4OHU1ZVFTcXVPNkd6SDQ0V0Zx?=
 =?utf-8?B?Uit2ZXlCalB2ckJkWmpwMFVBdzI3cGpVMXlPUFBlNkVJWlJWSm1xaTlXOU9i?=
 =?utf-8?B?T1BJSExqbmx2OXpGYUhtQVdhNEVwSWVsOVV1STZZNytlakZsL3ZUNy9PMWkw?=
 =?utf-8?B?TSthOUZ0MVZGOGhCdHlGR2VGd2NsdnUwV0gyRFlZRW56WUg5ZzZSU2NESjI5?=
 =?utf-8?B?Z0haMDEyK2gzKzIyNXdIMFdpd2YvN3Q5QlF3cHNsU1dGMkdyWE5YUEpBZnRC?=
 =?utf-8?B?bzhBd3VBNUl6by85ZTBZc0kxbFRObzNHU0NwNFZaZ3JCYmVUNWRYdEx5azZt?=
 =?utf-8?B?WEVKWGR5VStCMGlhOGE0SUs5N0JoelNMd0ZOanFJcVBneDR2NzhrYmVaTkFS?=
 =?utf-8?B?dVlTUFNvMkdXM3hyL3hZN29TanIyUGNYSlB6MVpLZVZ5ZFh6Y0NxV1ZEdmZE?=
 =?utf-8?Q?sZQWeSfbue3da8NTZVYRMkI2U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jLqj7/FBRFp1hTwkFq4TikCsSn9ogdfBoUi+i7oyoViKdiAIpdIIjdwZoqXGP2HOA3ti8+0GWm4YB70odSkkbT+2vKLRPb2XN34lCykIXJi6SPjFJztfMAcRJ2doixhFIqqf02PdBlM3S3XadXM9OIKSm6Q90STZB0t52hFuy2MVlQU2adMJm3tSS3NMO+i9x4prkHUxraumFh4wmebZAZ2jXA3RlGtQm3T1dgcvjWQlu/aA47wdgNK8lOETOrIoUSsZCQUKzwPm9Byj+KbcOmuf5EjLzUcU6CDsMsbNhQMsB6ymowfGdfPSKOxk/LkbwH7AAgobWrTiwYMzVDUBuIQkWfZbhdvcsl9lix0mpwgaVNwXsakZTpOtpeW1lOdZrWB+BsBRioYrrHMSiVBd4pKEjsa3lDUHYc/7Db268WrOFxRyBUdNb1YQFF59A+pQn8xAmXcR8FXyeE4WmYxd8yQqsjiIfkFpFMQ1NhNRTod4FWp6t7R7dwya+REMQ7lNgPie1N5ad0ZxvwxHRgXD0bs20Hb8ZH5B6kaUoCyTvIkrYM8Zdo9JN1n/b235mzI3thoCqmFetBpXnQW1lu0BOFXMWfYcoFljtyY9yXSUMWmcJ+n2XVGyTkNC4g7lkIrmMEl/MkxSybAsYYve9mFtNUmjyGrcy+UHhq+juYhoooiF5n8ozbUJOMkjrOd2q1lupskV2EhYx7gpl7fSMRljkdpNlD2akPQCmZIHQh1VS6ZFCJlAWdy+WR91UW9vjElo0nWR9EJbfxN3nKlVx0WTgLNcY+3cqBSdi99jynbIfuSK//SJ1y7MhMc+cNGpPBLxtWU+8c2sO5yKWesf6Sm3YL/puS1tC/YUuazjUKgrNJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376d7ab-7681-4d8c-511e-08dbc3466a29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 12:52:20.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKHq3eP+yvUuiLxo9Y2pT9WixSDwOh9BpN9RjQFrDnvU6DHVsk68E/k1lk1X6o/jlinU0MSvp//DdmeQNF8FEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020096
X-Proofpoint-GUID: ukDXTCHqi4xzxXBESUYYq2MAC7woLYYy
X-Proofpoint-ORIG-GUID: ukDXTCHqi4xzxXBESUYYq2MAC7woLYYy
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


   Gentle ping on any comments

Thanks, Anand


On 28/09/2023 09:09, Anand Jain wrote:
> Guilherme's previous work [1] aimed at the mounting of cloned devices
> using a superblock flag SINGLE_DEV during mkfs.
>   [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/
> 
> Building upon this work, here is in-memory only approach. As it mounts
> we determine if the same fsid is already mounted if then we generate a
> random temp fsid which shall be used the mount, in-memory only not
> written to the disk. We distinguish device by devt.
> 
> Mount option / superblock flag:
> -------------------------------
>   These patches show we don't have to limit the single-device / temp_fsid
> capability with a mount option or a superblock flag from the btrfs
> internals pov. However, if necessary from the user's perspective,
> we can add them later on top of this patch. I've prepared a mount option
> -o temp_fsid patch, but I'm not included at this time. As most of the
> tests was without it.
> 
> Compatible with other features that may be affected:
> ----------------------------------------------------
>   Multi device:
>      A btrfs filesytem on a single device can be copied using dd and
>      mounted simlutaneously. However, a multi device btrfs copied using
>      dd and trying to mount simlutaneously is forced to fail:
> 
>        mount: /btrfs1: mount(2) system call failed: File exists.
> 
>   Send and receive:
>      Quick tests shows send and receive between two single devices with
>      the same fsid mounted on the _same_ host works!.
>      (Also, the receive-mnt can receive from multiple senders as long as
>      conflits are managed externally. ;-).)
> 
>   Replace:
>       Works fine.
> 
> btrfs-progs:
> ------------
>   btrfs-progs needs to be updated to support the commands such as
> 
> 	btrfs filesystem show
> 
>   when devices are not mounted. So the device list is not based on
>   the fisd any more.
> 
> Testing:
> -------
>   This patch has been under testing for some time. The challenge is to get
>   the fstests to test this reasonably well.
> 
>   As of now, this patch runs fine on a large set of fstests test cases
>   using a custom-built mkfs.btrfs with the -U option and a new -P option
>   to copy the device FSID and UUID from the TEST_DEV to the SCRATCH_DEV
>   at the scratch_mkfs time. For example:
> 
>    Config file:
> 
>       config_fsid=$(btrfs in dump-super $TEST_DEV | grep -E ^fsid | \
> 							awk '{print $2}')
>       config_uuid=$(btrfs in dump-super $TEST_DEV | \
> 				grep -E ^dev_item.uuid | awk '{print $2}')
>       MKFS_OPTIONS="-U $config_fsid -P $config_uuid"
> 
>   This configuration option ensures that both TEST_DEV and SCRATCH_DEV will
>   have the same FSID and device UUID while still applying test-specific
>   scratch mkfs options.
> 
> Mkfs.btrfs:
> -----------
>   mkfs.btrfs needs to be updated to support the -P option for testing only.
> 
>     btrfs-progs: allow duplicate fsid for single device
>     btrfs-progs: add mkfs -P option for dev_uuid
> 
> Anand Jain (2):
>    btrfs: add helper function find_fsid_by_disk
>    btrfs: support cloned-device mount capability
> 
>   fs/btrfs/disk-io.c |  3 +-
>   fs/btrfs/volumes.c | 75 +++++++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/volumes.h |  2 ++
>   3 files changed, 75 insertions(+), 5 deletions(-)
> 

