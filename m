Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7F793866
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjIFJf2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjIFJf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 05:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8A1988
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 02:34:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386953KH030145;
        Wed, 6 Sep 2023 09:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=msfm9kcEvr+k96RmFhyrqiNV6Fdp7a5JiD5ZOwzMR2M=;
 b=jpp2mpoolgj9cYKxLfJDd5KBslLtiQHqlNppZQGfB1Yo3SPFnzvXl49ybI4327HzNOgW
 +wOOQqtpgx3CaV1LrCu53ccurMaw8uYfoKm2UVuD7jZWKW3oOiKgmc5YVP9DSiUrZ/pV
 lrW7+w/6+jCy9LTvgvrb33aT1WmNMPXNcDeiz+/sBi8aRYfY11TZh7aV/+OSyS7lWa98
 9X+qilRYb3WV3v/bFfMbc5HB+bBjwaUHE7cpN5TDKJY9AfRN4sHCKDfPXhPYCNKrOhq4
 YyL4tFWuroMXoYk4A4hGGDfPoonw5h6TroSZ3RkV/NHysEadMzoR/M6eflj1PaO7cEEG 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxpfqr2mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:34:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3869TvlF028150;
        Wed, 6 Sep 2023 09:34:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5yqy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx4aWb0i2oCMXlC45XB736DcrQETk7lvChI+1h4eP78yMAU4CNdDG5U01jjnyX166UkpF5LGdTuqsk9MecUYkiDUTqZ/V5FJFG/2rhX6i9zTPl4CIVpxDTM3tylEmdtP+GRKjfw8sbBIebwARO1Dw92l04AYYgbuUsF1hbzZfcHtlKlB8MIMfk2Wk2lTX7qyf5IcMCelZtxY8XxsunFmpJiwaKzxNxdCeQ02fMNUVzsF4rB/xIu5pDaaa4D2MaiFp+e5zdBcgMmA3wM9RCVVUroaPXjEM2bVZeWasco1gbqVAVE1pSoQ/FM7eEgxCPEvffypgU+NJWkl4X5ctQUpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msfm9kcEvr+k96RmFhyrqiNV6Fdp7a5JiD5ZOwzMR2M=;
 b=bFPK1tNuwh+16g/T5HYoHKhE54mJ3eTtO4yT2iDRSJv9ytn49IGRVxyo2Fay4olbpLhG+jmwAZx0jUGeQkormB9WP6q0qylGKQCbq12QKDSR5PFNyNsQ+re5KzcvKWP55PHDdCAATubyQvhK3PmjF0+CvCclouZVwBBSWaVhQrck0mru1urnOmrQtKRAMeTBUqtO2xgSS6fGeFTxwJmqXUXWLOYEjD0/8Pd7sXOBVlYtMYfy7ljr+qQItgxPF5Qn4YzQ3O+L5M0p0w5AZQbM3+ZKxBkrktBThHu1+N/6iineQt8i9iv6fvIBjZHcPyznEmb+pfb62uv5kfdansiB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msfm9kcEvr+k96RmFhyrqiNV6Fdp7a5JiD5ZOwzMR2M=;
 b=i6gqVLnz0zLgEmqKCd+lh+o6OWGGDTPSBns5v0t65d+Ylty3w1l1IQ8KIy18WZqUOaSnx7jdg76rg9YfMFeLl/qC8cse/710M9WOp/xF9Y3nqIe+L3qR/M2gE1/cbkvxeUiB3QCjpKeSCIBT8U1Ni+DuAhvhpW0DAaJFByFUwX4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4967.namprd10.prod.outlook.com (2603:10b6:408:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:34:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 09:34:22 +0000
Message-ID: <bb023679-f804-97a6-601b-56a161ef5a0e@oracle.com>
Date:   Wed, 6 Sep 2023 17:34:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] btrfs: warn on tree blocks which are not nodesize
 aligned
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1692858397.git.wqu@suse.com>
 <09481f8720302e0c4aaee7e460c142f632c72fe8.1692858397.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <09481f8720302e0c4aaee7e460c142f632c72fe8.1692858397.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 08015059-9bba-4c88-fe68-08dbaebc73cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQD9oxhzPcpD3PD/9FDsh8Z1t7CRqssXrV2NJARtIh9B0jTzRu+1TjX19L/Ug3otP0X65MZYtO99Y9zNjXKHHoV7p7xwYPQ8W7J5cPIROmQdg0aWMTfOKbvmzyTtQBP1cr2ju2TPovnC1ktbjGF/4wUKSYVcT3X7v9+UUIKoB1KR3SjYkNS0mDbVgn1ngHQLpRHAR1kIoajH5Fx4ivWkWmeszCkrw/J9sCVh4JqGNncCVA9vjHeU+PjE9qM4a8qjHOdXv09TIHi/aVEK0lH6x6uE8iuco1YKRfPdsIrZkddJvpno6jgO/P2xUbJPNxddk7NGQPqeEficyh5vcX71jfBOSXawdMBI2hNkF/Y3xjf/Rw1hKOfagyT6o70uBo2FdbwHqmIvo/vy8dedFDRrxUYOUQ8HkD6vXAjz94WsDW+bIx3FZ1VZc7xXdJ/hBX7QSYaAwBQrWs91DZooh2DOIM58TBQw+Reu718Ubmxy2cfOJoJfJ8vg3c7xczMViOALfTzYxOK/y5mraB+Wa7nZTwOqZA90oiScrz6QFX4KNaTbWtRbHqYYILmWyWWfUJNVaLcp2zKIA+bAl5sMm5SlCqXHCzNqu4GjzA3NvfyRUpm1MPPFflbXqDvM0TD9QKLruq/+sU9m//AtC4QRWvivkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199024)(186009)(1800799009)(31686004)(53546011)(6666004)(6506007)(6486002)(31696002)(38100700002)(86362001)(2616005)(2906002)(4744005)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(5660300002)(36756003)(66476007)(44832011)(66556008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtiWStHMnVGRStoY2pCdm9Eem5vR2ZiMGFIUlVnL3E0TmpzaTlUeGNrOHJI?=
 =?utf-8?B?Z3lBdGR1dTlxU29uRWZFS3RabG04NmFBOVVGM3B6MFlhYkd6bXRRWnN3ZUFx?=
 =?utf-8?B?ZTh2eDgyL21vemtGcHpudGNPMHFva3FkeENDWnl2LzRNc1h5YWpudi9Say9S?=
 =?utf-8?B?Z1pIcVlSZU1CSUNLWThva2FyVDlwUkYvRDgxd3lUMGI1OVVoWkFRQmJDRFlS?=
 =?utf-8?B?ZmI3bDRYWjNXRkgxL1hrT3VIYzNmOXdtT3laZStySjBNaW9IQllBaUZQQSti?=
 =?utf-8?B?TW9NenRQYVZUMEtBeld6RXZ4WEpHSmtkQkxWdVBlYW9TTmpvNU5rbWxZVyth?=
 =?utf-8?B?Z3dRbkxXdUFJRmNHSHlodkVjSllKZE9Uc1RnRDFZMmdhY0h4ZElMMXlqbURp?=
 =?utf-8?B?VG41N3pVZjd5QlAxbVJBeUh5b1ZqNnhCbDhwQUNvODJiMTBkekc4ZTM0eVBl?=
 =?utf-8?B?VW9zSW9ENTJuMi9leUFGL094YmVyN3d5NGpMaE4xRlFIRW1EMnJaVWhMaGRY?=
 =?utf-8?B?WHQ2VmVJZUtCSmZEWVFCTlV0TzBjVmFaUkRxZ3VPZGJzZWRYTm1mSU1QaWlu?=
 =?utf-8?B?dDd4dXdGcFM2Y2NwRk51TjQ2aDRjdFFjYkhXVUc0ZVBtcXlsSnUzQ3NmdThm?=
 =?utf-8?B?S2d4TFYrMXdEOUJQVHZaWldVT0FkWWgrVjZ6czVQVGhBN25XNEpISzVLZHVT?=
 =?utf-8?B?OFR1cWZ6a3NnaXlnSHA3K3FSd2EyVnpZMXNvT2RHTmhaWnN3K1lOOFJpRFhX?=
 =?utf-8?B?R1RWQjZVODBRNksrZE81WmkrV1lra3NnZ2FjU0dybFRxaGcxOGdUMTZ0RXhz?=
 =?utf-8?B?UmI1aDRkTGlPV3hlem0zeCtOcE43QjYxenBpTzlYSUpHOUEwV1lYOWJwazBK?=
 =?utf-8?B?UWgzRmNHRGFVSkRYSkdaU1JmaFdBMHBmU2l5b2NRSFRSUGMrTklsUFpvczEr?=
 =?utf-8?B?T3BjRy9KbVBxdXFQQmlyQStybXg0QUxZbHFGRUVJSHdqTUwyWmtLSVFWenRJ?=
 =?utf-8?B?Y0dGUkVGNHczMEQvaWN4S21IRGFGeEJiSWU4NXpCeTZVdEVWRnZYU1BIQjlR?=
 =?utf-8?B?dlZuNnJhQmV2MTlPa1lDUXl5Mjg3WVVkTXlaWW9qK1VBZW1waFNqUENreHND?=
 =?utf-8?B?YWl5OFRVb1JHSTFhV2dIZGN4MEVweXhUdHNDZ1hWbXJlYW9JSndxUXY4Ky9Q?=
 =?utf-8?B?MFE0anJjUy9jL2FYQkRjRlJaaWRXc0pqVFRZVU53c2pvNkl6aE9KZUV6ZDNI?=
 =?utf-8?B?RVcvNzFaS0JxZm1lREx1QVdsbmhsR1VGWmN5UjNoYWV1M0tXQUhmclF1ZzZ0?=
 =?utf-8?B?YTMzVFU1c2ZDYW03bUpncE9ia05xQVZ4WFd4ajFhRWpFS3NrQUdHRUJzU3Nw?=
 =?utf-8?B?RXNZNVhXWStxU0JsZ0xhRW5aRXV5ckhiV2l1eVhMTXlrcU1SZWFQTjhHaVhR?=
 =?utf-8?B?VUIvbTNjQ2x0Nm1EanRWT2dndlJWUGp3NGo5YStJR1NqeG9VTWJ5K29Mekg4?=
 =?utf-8?B?NVF4V3UyczMySjFwUUJCSHNYdDRnckxUZk1ONTRYaE9QeE5qVzlKS09Td3Y5?=
 =?utf-8?B?Tk13K0E5dHNyY251TVdhRFdrK3JpOW5mVVNtY2J6ZmxSTWlvaVpxNS9nWndL?=
 =?utf-8?B?UWxSNzZzQSswZmxGWkFLTEk5QlQ1NzFCQTQ3ajZqalNGMUJFdXFOcUd2ajlx?=
 =?utf-8?B?OHF6dkhZNWtqUGd5WFBjN3VHVWZqdnpodU0zeFNEK1dwQTlXYi9aakRVNzZB?=
 =?utf-8?B?alpHWEdQemh4czZqZklmcnNDRzllNTU4ZDFibjZMQ3hvQVU3d29PVlR0U3ZV?=
 =?utf-8?B?aWFWaGg3WjRGRkc2SXNoc2Nlb2FEYjU4WTc4M01XOHpTKytsRng2MlBaazVt?=
 =?utf-8?B?amhNQTI1bUx5eVNCR0hoNlZ6am1qQUxJNkNQN2JkVTF0dXVFVU0vVVh5QWYr?=
 =?utf-8?B?SXBzVVNoa0hkZE9kR2JFVkNWMWFTSGVRTEg4TC96NjlqMGFEVHRwcHNyekdt?=
 =?utf-8?B?L1lxQlhLMDZPNkY4dDE3bW42VXMyWGRUd0oya21IWDBFSWc4K0Y1by85S2RI?=
 =?utf-8?B?K0J3Z25lWE02TzIzZldYbVhkVUVTSzdtTFpzdjJnUVZoZk83TWlRTGZoeThD?=
 =?utf-8?Q?GCx7uF2R2noGJPLdmj7S0k7yr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: euLB4iIAxI3AoMfNy0hx++IarPlTuRpQ7hkX47QdINvCjuzRxT4rjNlqhzmRMp5G1m8pNGh7ERqqskPvsZlNuUvPL2Hnx6ddNAu4fA6ZqhlctyeAYMgEq9eCCcOwAHb1E4mqIMDNOxxMC5QF4izGxXGsihW4atj+Bc/SK+DshwxI4YMauiqslHkTf7eJzZSrEsIqEYyBzv+mYLxrw2GY5zhKBERb5WZLbLmBYrwbp8wx1TzSWItlbvEU7wJ7U1SNSedRMTt3WEHbCfncW5OjLCBJHYmOXBkvPIUE/ecn8TsKIUT3TtQph1UgoUIyXf5iNKjnEAV2Ujk21ulsjaHjr6Wmws56IHgiF6Yw7LNeH5SPLpHxllIvUZcHdHHURok33nr3ZVwc2w879e1/54LLebVUwALKvDIlG3rLK5ZThaUHkwkZXFJZSbdZKxMks51ITmAQHgYJkha1Q1KdiwqVzaJKJ7D01klw/cSjIi2maKgSbrHlWnO9I7E/1oQgErIuHXMvPcd3o6VydwT5EgFn+zYTF6tuRRbM1my5PH3+VUmxYq0BIXYRa+6Rr9kOlh32F+9VXLRr5ijANFe9lld+Bb95xOEe2wDaMOMLRngsbQXWQWepsCyp6L4HtAJSKPGECTrVamqk/dOKOEPR9BFePVZNw8hhAa0KtwwTq0/bwPaXc4VcAooqVhLxTt+PCuGAWd4snhJ0ndfJiPbVAiJXuuyZU775Euf23pI79wGiIrCeDYEnp6HpkxGa5m5kuvFHO5iB8dF1+l11xIEMDSLRQws7jFH2WxeDsPMQQLJxbr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08015059-9bba-4c88-fe68-08dbaebc73cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:34:22.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFh+72p05KSUL5UaCWuzh+rHKjN0AwpJvN8zCfi9ym7O+wsbV4aE/+wB80cWkA7SG8ePEPyLYdOJo0Vn4YpmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060080
X-Proofpoint-GUID: XfMnVZfqpleFWo9vhWh2kAun7QMpxvRl
X-Proofpoint-ORIG-GUID: XfMnVZfqpleFWo9vhWh2kAun7QMpxvRl
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/23 14:33, Qu Wenruo wrote:
> A long time ago, we have some metadata chunks which starts at sector
> boundary but not aligned at nodesize boundary.
> 
> +	if (!IS_ALIGNED(start, fs_info->nodesize) &&
> +	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,
> +			      &fs_info->flags)) {
> +		btrfs_warn(fs_info,
> +		"tree block not nodesize aligned, start %llu nodesize %u",
> +			      start, fs_info->nodesize);
> +		btrfs_warn(fs_info, "this can be solved by a full metadata balance");
> +	}
>   	return 0;

I don't know if ratelimited is required here. But, that shouldn't be a 
no-go for the patch.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.
