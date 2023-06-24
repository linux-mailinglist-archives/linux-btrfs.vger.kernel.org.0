Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371273CA66
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jun 2023 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjFXKKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjFXKKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 06:10:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CC19BF
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 03:10:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35O8HbuA010848;
        Sat, 24 Jun 2023 10:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4bfryU4/xbeCl1L2nVQIt8TWH8Dn/lY2GEFokS8z9DQ=;
 b=xabrP3yQ5mNPxe1JK1XiElA0BGh89y/yyicMMxkiFLlns1rjtJl6F1s6Sct6+C6tNxiy
 aONazM0dPLmyIEu0BQDPMd7o6N7HnOfOikS/7Szq3IzhP5EcqmU5TvOPfda1h+AyijoF
 txDajP7sUtxnqaKgp23ruzBy8Uuypg+4dgWx0LZGNZPRQ3dJ54ACewlL6w5WBXZ7fY9m
 aQ7KwQ2R/sRRNpMtUqXesesp0j7oAil0yUZqahlj9GmJLoDK93LkPKYJ2BlUixtfKHjY
 4n0L1LUtb14Dsn2cia5SFdyeEcPHK7U+Wydg+RLuv2hIyvwemGOD+Qm9l++bZkYoBUrq XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u05sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Jun 2023 10:10:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35O83HnB011169;
        Sat, 24 Jun 2023 10:10:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx1ay0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Jun 2023 10:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeGG+tRkoqkA8FSvmPk5aaaVJMdb4xq0mc3FTIIVF6w01G4OcsQ3daGWyTof5pBgS05vmj7ZnDDVfdFehwxz0DTo4XJCOlWmzgwFzX2BDa0Vi2qvH+AQzkfCqJK26ZwJ5rSP3VPbkaCF/p/AfKHAmUwYLkl6JsX/Lt1wJ7LUWquMzp1Ox/l17aeOZl1/JucYgJlO1mhtNnoJj+gbFRKbmdxai7UeEG2DadAooShWWJGh5LMgGFcCFQQGT9qLVmHkSme1Pvw8KVvnt6056V1JvVwOlzYMqP62f8VLDvG5EsHj2e3UE0oLtWHrOEdY2WY3bxh48l4dBdj3ln/bQ4eneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bfryU4/xbeCl1L2nVQIt8TWH8Dn/lY2GEFokS8z9DQ=;
 b=BpgCE3B/GSrnbwBRLIHV9hmm18x5tU/BOphMZAyPiLKWXs5SgNy6uuZzf0U9GQecxo94x2NNPYAwu92ALqD5pffveao+kFG00vokNnuk2l2LvD7x+5+gfkfAM2cMwIQTk2b6lcr+i0ikt6YF6VGpqFLSI+iNOEzdx3X74fUw2ITs78lsjfd4Su9McCTbI7nWadcJfz7m6MbShWqAE0KlAAHqYD+eMFRG8axAl/g8zy7yKjy2SHF38vCn/jaZ9jNxEcSIL8qeEQ8E54MMmoYinOGT5VtzqdKljGFnnXleiU5ZQo65F1u+gaS6CHI+chxz5bTtFJ4EqMUKux3qlyeyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bfryU4/xbeCl1L2nVQIt8TWH8Dn/lY2GEFokS8z9DQ=;
 b=AEgMwLrB53iVM2DQ8SoBbWBeaHNLc7Q1B3lhXxbQ5ub5ET8x9QSXJ/K75VEokpiHO0G8wrGWduEkob1IYmZCSHDR1MWdk5HlsVTAz2JryFqFNlhetWoodNLURPJm/E2ZkGYMApetry0v9himgWBQX0pxvGT6pBpDCwUuYQp/0ZA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 10:10:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Sat, 24 Jun 2023
 10:10:08 +0000
Message-ID: <1831cacc-5534-112a-28f6-d6f1f63ec422@oracle.com>
Date:   Sat, 24 Jun 2023 18:10:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
 <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
 <57c09714-ece4-ea89-0a20-7390c85957b9@oracle.com>
 <0b53e722-fdd5-e181-e24a-ca2d3c91b8dc@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0b53e722-fdd5-e181-e24a-ca2d3c91b8dc@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: ed063667-d390-4a35-3bda-08db749b303d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSMnAHOQKmkDdqMsQj3TLyXe/ol89YiA9WojU99IRY94ZrgIDd9PmDCNuujSscHEGZU8tb/1677+OGUOEWZ5b2lQWf4f4BFnjvRJqlv0JwfwExtXVycrGMWNiR1GBDh3HEadwZKB/++fKRSjYoZhAg7fa6w9A12vpC+icUI2yxQWu+1MO/FwiZyzxfnNvxsm55jKOBgFkTBn3nZCcyYQ0TuJYM5GQilP1oIKCBi9zfSPSGbkyCHfEe2rW9qbyNydkchWSK852PXNF2Af/0fvbLBWfpXwvfvYJnMy3VJumwUyITp1yPmbdrq8JykfzGJbX3GXDpUXyF9Ic8doBL5jE2dHWaqXWuongjaTnjDNtKmZa5Uo6G2kxU7pg6BO5kWbyqKDVfjmPhqHMyYcertCyJt3gAZTcIw8cjYeMHBkYmA5VmVvvIzG5WssZSavalLtH+wpr6Ic7v6enoL4GbZPgDoc8FZPvjRAEtxcZurap72iJZpyZ0i1KrPVuHTCueZwzy+6Sp6RzTYySuoZ2scm7r+EftGjt3yhK+VjG4p85Gbjmf/eTxw4G7J6S3VwiVsi9pcLIg/Y8JBSU6DazErpmXatN4LG4AplxeGgxsW6C6HDPDbmlUdVp85zmuHZL1vriMwvTb1qNtNlBgb7wWBwCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(31686004)(36756003)(5660300002)(44832011)(41300700001)(316002)(86362001)(66476007)(8936002)(8676002)(66556008)(38100700002)(31696002)(66946007)(6486002)(6512007)(26005)(53546011)(6506007)(186003)(2906002)(6666004)(478600001)(83380400001)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkV1WGM0WGtNQ1FwdHp0a1BkQldYUzZRcTNRRkJlVDAxMk8zNVlvVnN4UHBr?=
 =?utf-8?B?NGx4OTBzZ3VaWmFsR0dpb2ZweGhmUTlPQU1OTENMcWY0Z2owRktSK29HK3Yv?=
 =?utf-8?B?T3d5bVFEaVZtTGZtU3BockFkY3NRKytqanNLTHRHdHNKaGpYT3BReFVLaU55?=
 =?utf-8?B?Y0gwb2wvRmdTRW0yMVlQTlplYXVoVE9MU3ZPVXllcnFQanFqTVB6NkFsV0xX?=
 =?utf-8?B?WE0vK05seFU3ZSs2R3dYWWhBWkZZZHFpczFEVmYyWGVLQzl1ZFA0L3Y5VUY1?=
 =?utf-8?B?aHU2SjNuK0dJL0pZTlZweDRSem53VzFma0RXeUNCV0lPQi9VVnJicWRLZXRr?=
 =?utf-8?B?SEJjRWlCT0szanVvK054ZkMwblM5RlNUSHk3djIrWjl6RVF3LzlUZDBjaUJv?=
 =?utf-8?B?MW9mUlA1b3JOaXdaMWZUZmVBWVdtOW1pNDgzMEtDWUszWENod1dKYStnb2dO?=
 =?utf-8?B?WCt0dW9yZ3NsQ3l0Q2pEK0M3YVlXMEhqd2xsNytGYUM0UmgvM0haMzJCVlpu?=
 =?utf-8?B?YVdZVTdHb045V1lvai9wVndlWHNjRHB0WFF0K3hXV3hEbmhsWDRYVUR5WDlU?=
 =?utf-8?B?c2hqUmgrVmt0SkpHVnpXM1FwbUdMYXVWZVpoRk5BRU5sKytDcVV4cDlGOCsv?=
 =?utf-8?B?b3AwRzZmKzdqdXNRdjBEcTI0UGFZZVJ2OXZTWlFnMkNsWVRiSUNHZGhpYm1M?=
 =?utf-8?B?UnJOMnpxY01RTXQ5QXFzY3RFNTJEWEhYaWVWcVAwT0RORkZBb1IzOGRjamhQ?=
 =?utf-8?B?YW45Tk5sYnpSKzZoTXMrK1NUWnExeXEzcm8xdmpWWDFhbVZYRkFDUzUxTEh6?=
 =?utf-8?B?S3l4dHg5NHM3bkwxREtKK3ZjUHNLVFpCYkdjNkwrdWZTUThra3NEZjcyQ2l2?=
 =?utf-8?B?K1EyWXZ2ZFU0NjNoSEtWWmcydUFUK2UvV3l3R1FMcDQ5OHhnd3JHSktVaEFw?=
 =?utf-8?B?N1VGeTgrZGd3Q05lSHhLWFVvUEM4TUxvZjZneFhuU1RpNXk4NHBZK0k3SnBY?=
 =?utf-8?B?STlXM1l5L0hrN3JnM2JodzA0S3cvM3hKTFlBb2xyWWtPSVRzODd1Q0FQSzIv?=
 =?utf-8?B?RTBqSjZBTmtaenBjM042RHhtWlZvS2NsaTFCWjdhajViVHpvT0hDMmdWQ3Ro?=
 =?utf-8?B?bk9lVGRnVGk2QktmVmlsMndXMVFteTFpTXM1eE1sVmtxSzBGR0NCaVQ1NWly?=
 =?utf-8?B?MUc2TnpPbC9DYjM3QnZoVkkvQ0JaWU1DbXBUaHFnKzRac29hNUgyWVVVNjdr?=
 =?utf-8?B?K25uTXJ2UE41SHloMHdXRlJ1bHdFblFlOEJJdEhyOGtXWjFGWWZ2Ulg2UWVp?=
 =?utf-8?B?ZmNJV3dpV3IvYUwxWjdyWGhBWkZJTVQ1NC9VaFFuR1dDSEhXaTRKWUJHd08r?=
 =?utf-8?B?UFN2aHV0QkZIM3dDN0lDOWlNUmFPQ3BNOVh1dXFPKzFJK3FndTBsdGc0YU5P?=
 =?utf-8?B?WnR4RFNTblFUVWlNdmJtQ2EwbGh5V2xGMmhYZ2ZINjFDZGlxRUwraEVXTFZU?=
 =?utf-8?B?Mm9uQTRDd2pWSmxhNlRReWVRUmh3QUY4dlgwNFV5WDlDWVg4ZDJsQWYrajVt?=
 =?utf-8?B?bmh6cDJHS2JoRVcxVVpUMUJUWkFCOHlJYkc2cUg1YjZMYXFlV1ZENTY0bVBX?=
 =?utf-8?B?T01Id3pvS3FBSkN4MEVPa0w0anVsR3IzSHlSOUp5YzVkamFrcDJPMFpwNk1m?=
 =?utf-8?B?Tnoyd0lVRWhJeFBOKzdyUkxoU2Y1VzQyR2JqWUVLNEtNSk9nMDU1bktvU1RJ?=
 =?utf-8?B?VjdqZGtmWDFqOCswamVtSUo3NVNXUEEzZ0FXb0diT3pVSUF2QU53aWQ5NXVq?=
 =?utf-8?B?d2JlSWhTYnU2R0dGZUllRVM5ckx5cGhNc2VQekF4dnV1TUQvVzJJRDZ5c3BJ?=
 =?utf-8?B?U1dIQnFZbHpQR1BBRXRiR3cvWWR4WnprQWNkSzdlYmMrZ3BrZUhQNHdnZUdM?=
 =?utf-8?B?VWhua09QTWxMTUlYK3RTSEQ1Tm5DRGVkSXZRUHIwbDV5Y2N3S2hSRWNHUkl5?=
 =?utf-8?B?LzF1RW9Vd2hxWHpCczVBRStQRStQYjVhVTYzVVA1STF1dTBkSUJjRUNjY09P?=
 =?utf-8?B?Yk9HT0ZtY1g3bjd2dWl4NlhGNDB6cGN4cjJLL0NWaDBTTmZ5RWtnY0d3Q2pi?=
 =?utf-8?Q?GOBNQaTmqZetgk4gnOhoq+rSM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h/mPhypCAb3VnPPtwYcAjWUo1mPuBNH2LkTDUW5Xq6CPvQidbMFSdrZqkIqNe/wKTb0QjOKvbPO7/V02duOFyWgcJt0mtx12UEH8o4Mfdym7w/X92Jy2enSTwbZWS0KCxbHPdJMDTYNmi01RMg83/AFCWsdd3P+Q28qGzqvL6Z0Yq1ot0cq4GmYn9vPZWbj7L3E1m9NicGTn2gwuOqKb+w3dL7EjjmB+FIrceO3sgZilmsX5i1jnEHi7Bld+1wDi2ToMmqa+MptQJd5YduASq6M9uqhyaMcfEwieAnEcvTEyiC9mIGEosvoS3fpd1hu3NUZ6S6eUrZybRwrIlXVwgn2RFyVMQIOoJOgnUm+Q+WBulo1uBJhqDOBY3WrXcLybH3QZ0g7VuWnaUnWhPPYu0L/zeyEPLtM1LW2OFdmmh953MCKK+KVemsEt+pftE19W6DRadNi4AP4hWSyXyGYIdMUSAN+TI03uJyjcdykaPj/i9VQ7DIsS7drxXqt9Wz7Qfez25N0ozR3BILJhutX/UOG1l5dOuC+xjWgbbKKZ0O/q4kIEHpQ4u32HYFipboMGVMG4pylgIHaoimborvm3SVelqgWeAiYAJrlhZOf60cnTy0R2FRvH8JZWez2gmu93+q+TDD5SPD1NtSf9EETs3u9iUxgVwhkE35zeVBY3U6PZiNtfx66Vut1nq+rwkf/85+hjndH6LQnylty+lO+Q3+kF3hbypDAShBRJle7ocPOX6grX9//SFzhNN7n4t7v/kV9uYmZd/GMBBVOaVWQgTJraeZSLXoRH7xaihEy+SF2VTmevrwR/iUkJsQbLUylk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed063667-d390-4a35-3bda-08db749b303d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 10:10:08.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNtlRfko2jjlEhV03xeO/rszLxL5EfOd1IPOKEujEvLBy3JAKD9l5SDckktRRpFxq/xfYanqeHX5maxeC2v2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306240094
X-Proofpoint-GUID: bSIzANN1-H8kkq48x3QvIznGzSPiQLQx
X-Proofpoint-ORIG-GUID: bSIzANN1-H8kkq48x3QvIznGzSPiQLQx
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/06/2023 10:20, Qu Wenruo wrote:
> 
> 
> On 2023/6/22 09:29, Anand Jain wrote:
>>
>>
>> On 22/06/2023 09:02, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/6/21 23:41, Anand Jain wrote:
>>>> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
>>>> failing because the command 'btrfs inspect dump-super -a <dev>' reports
>>>> an error when it attempts to read beyond the disk/file-image size.
>>>>
>>>>    $ btrfs inspect dump-super /dev/vdb12
>>>>    <snap>
>>>>    ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
>>>>    ERROR: Error = 'No such file or directory', errno = 2
>>>>
>>>> This is because `pread()` behaves differently on aarch64 and sets
>>>> `errno = 2` instead of the usual `errno = 0`.
>>>
>>> I don't think that's the proper way to handle certain glibc quirks.
>>>
>>> Instead we should do extra checks before the read, and reject any read
>>> beyond the device size.
>>
>> I implemented that in a local version, following the kernel's approach.
>> However, I didn't send it out because the test case misc-tests/015*
>> requires dump-super to work on character devices like /dev/urandom,
>> which is an interesting approach I didn't want to disrupt by modifying
>> the testcase. Another approach is to check only for regular files and
>> block devices, but it's not a generic any device solution.
> 
> I think it's completely sane to update that misc/015 test case, so that
> we put some garbage into the backup super blocks other than relying on
> the support to run super-dump on char devices.

Yeah, I follow a rule of thumb to avoid removing a feature, even if it's
not useful. It may just be that I don't know how it is used.

But I'm okay with removing the facility to pass the character device
to the btrfs inspect dump-super <char/device> as you suggest. I'm just
wondering if we have any more comments about that?

Thanks.

