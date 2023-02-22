Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6569F654
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBVOTO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 09:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjBVOTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 09:19:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465929160
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 06:19:05 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x8Kx001458;
        Wed, 22 Feb 2023 14:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=stSymzhtTk+fKrVoasGHsn7IMEmb2u8zqweVZJjm4jGCebBFrd/QBYnhMEZkLp9f9vpe
 sFITRjSTJw13mbyDlYP8rKtvVhB9h+2kZyro8RkY95K9dfg9dxEhqi7v9LNmW5DHAyxM
 NXGHGt73DOcHBX476kC/1CAk5km12lqRuVlZdISahLYh5GQjB8M/rTQi+caBh1SPoU1I
 jRmPx81Aw41ftWuXhJ6GsVLqg7MbnDxWmM60PZJHHywHhQLCHp1+SdCCnI4mARm0EYmu
 gX2/IEyHdcimM1VS84phwTkRBe1YOwBPkaWO9kMdfwDaYBAFDj87erusisOUFhQ+//JF Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcg1tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 14:19:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MDjHn2027313;
        Wed, 22 Feb 2023 14:19:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46v5nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 14:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVapn2WqhhhfY86hb6uDWDSUBBUV1tDMTFMumpYvDmkbJgPCK8j/8bQMak62QTQXw1ILsTNQNY6O4LFpFhd7bGBLIbmxCz7MXjcmeBV8uDqBB0Jkgaf2H3u6d4xz8rXB9YtU95Z6hbMTgJDOjtFN9OTvIzqFgosFoil10QRaAYo1fR6Vi9ZIdRgvtTgpsFxpxP06D6QtSnP3e8Wo8Ek7bqwq3G8CJwIs26NJxZXVTEals1B3W6eW/qXAbcE2j9YjBbRt+BN6AoM6rcwqTKQPVSWlDl3zv0/pFmUHA8nsKLSnlv36MkfLPEydEXbpp4ml26r2mR3rnspr31ZDR3En4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=ZK1tx1dzxtLI8T9show+zRn4yeKrEzcqtUpUbgtnJ8hEUksEf7cayf6SiRy3V9gBPcj/CkIO7IGWxHFPGdnTBfdxgSAhFay5TuijEjfeufn3lUwrv006dJZSzU28uZ7UHYXVDSrEB6Zf2VdScwiWbzDY4/54KunxXdhnD0hsDBFhHi+ldUXRZjiYE4DbCxBeO15S2Ng4Qm6xu11ypGBqzrhYjXb+bLhcLCRX8QIpgc5wOsLGTzfcKC8wcrlW+SSnU7A9tccb+Lc9Ry2Xb38gQWqzspjLJA2ozRA1ei7oGx0rZULmUHB36EBWf2WCnrKDVGGVMhwMNwAS8ek5Zp033g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=nirvV4wpEKtAgkAIVKgBHjfmTMcGZh7ZcyaDC63Wx86hrsit4hcQ1d16NyfwUTADxz//YrRuktUt6y5zgLQoGzpLr8v1g1dX3H8wSJbqTaSk4O87FTQutNa01kbn6ogo0s346XRdtgbDP5zeuL+YsnRiq7D72VE0wayEqj0yZXU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 14:18:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Wed, 22 Feb 2023
 14:18:59 +0000
Message-ID: <4670080e-9e0a-3d19-28b6-99811f084c10@oracle.com>
Date:   Wed, 22 Feb 2023 22:18:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix percent calculation for reclaim message
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Cc:     Forza <forza@tnonline.net>
References: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: b3014d06-8570-4fe1-e7d1-08db14dfbd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsPcXX/whPA6WWvsFTRSsFIzDSPFAyoOCZar4voAaXBPEWEEl8AU3KleuTqVxVQpUU1wtcEtI8fi2l/cuwFRCM2w7W7suMPDH80wAUaNUvoUF3jGhaiD+4Q6K7yYWPh6xdGWFY9+yc6KoZq45l2e9WYQd9HG+aEi5wJWVV1whIPamlEfivb0dvg8WPy8lf86KUpahIwKXfx2/du3rblqwfKNda57htoef/+cBIhHXAft6pk9MC0mdVv2k9aML2pWwHa6NWSqPRbkPt+SK4i00oLA2CPQ4JCy6SExr7czONyMdlDfgg8deNPi8zwB9zbVrM3r5ruVjLNiX5RR8ol1bnE/+6MUrBgBB4LKtIXQyh8NnodgmdxdgwaD6BhwRxtV7oz5NanYOl+2sytblaHiOWdV0LfzEu2tM5D2Bpyz28yM4jtC9vogC/g/VqgcIIhtYZDjWU1obARkZGxh/VzGlCdtfqSnahUjS14dsLA8snfJ9U4Qj10hpvJ8VeqM+eLcMEoGu9iys5ZbWGqR1b/oFvNhhlQVD1frKJCsQylIav70H08Gwo7u+usrcBP7VOsQdOzxYxHpFv1pkV227W0oXG3e99TNyxhR1z0qhl93yVDOeTsdPzR/TrWvshhT3uklht2473zhmQ7Lpqpvo7GecfyzX3c54vINbEAQC8tYcJ8SXLktDk8BZnRxM3783pxc6eopzis0ftCQ4QPZjW8qcfaovElWA5jixdT+RynvuN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199018)(4270600006)(31696002)(19618925003)(36756003)(2906002)(2616005)(6666004)(86362001)(4326008)(66476007)(66556008)(66946007)(44832011)(5660300002)(6512007)(6506007)(8676002)(8936002)(6486002)(31686004)(41300700001)(38100700002)(26005)(316002)(186003)(478600001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxSbkdMYXU0eU9BazdqeVNwUzh4TFJiazRzN0h0TG9tNnlZaGVqOUZ1b25s?=
 =?utf-8?B?Y1JyVjFnYUxETFllbHV0alJJRTZRS1J6YTBqM0JkVldrZ2t2cWc3NHhqN0RS?=
 =?utf-8?B?NjNLTjRpclZwdnovWXZsVlF6cW0zNDZMUlZEb3BNUjF3ZjVjTmNvbll2bTBh?=
 =?utf-8?B?OHVMSWpKdGthUUdReTg2QVBOLzk5WE93NHN1SHJaZW1VQUVvRUdwMXZPZ01C?=
 =?utf-8?B?WjBKUC9RZE8zU1pwVVJRUkNZdTBtbFF5L1VsZjVoNWFscVJrOHY1SlhhR0ZI?=
 =?utf-8?B?aWt1a0FCNTJ6YjllOVd2dFY5M0w3MXBnNFBJRytLQi9ubzFaVjExRFVEUUp4?=
 =?utf-8?B?UWJDYXNuSnVkNHV1ZzliOFVlL2h3N013eHJlaUs3SStmV0F1ZTE5OFZZQXVK?=
 =?utf-8?B?bFNsTUJrTTNmUmhKVlZmNFROZmVrYUYveGttNGlzN3RPTm5yOVF1TXEraHRV?=
 =?utf-8?B?elZranhLRmJ2ZjgvdTFjdjFQU3V5VkdTK0tzOGhzRUw5alNrT003ZmI1TmtH?=
 =?utf-8?B?Wjh5Mk1hK21MYzZOYWRQYmZKbjFtd01McnRMMGFOcmplcXFEZ0RDa1Vpa3M3?=
 =?utf-8?B?WGlVMEZxcGE1R1dKaVZmVTczVS9EUVNud0l1blVKZld2RDFWZFhhTVdMNHhJ?=
 =?utf-8?B?U0MxWHlOZWFISnFFZFVNaVRGa1BkTTllNWpKaVJSYUdqTm45OFJHRzk5WjRk?=
 =?utf-8?B?VGgrOTdhblpCR2ZHdUxUa0I1ME1iS0h5VEpaZ3FJZXZBN2JGdWRmZmtzZU5P?=
 =?utf-8?B?bkpaQzZoeWpjdGJYcnUrTzI3S1IwdzVrdFg2eGcxWDc2K01NeWNlMFhUNVVw?=
 =?utf-8?B?bk9jdXB2UmtRZGN3bzlVK3ZHdUpRWkZIYVBHU0dhN0EvT3lZVCt4a2NJU0tt?=
 =?utf-8?B?QkhMV3J4Y2ZiQ0xGdXRFYTZwOWVmdFNpYjJTdGE0TUd3bnNjSkNGTE5IY29a?=
 =?utf-8?B?cy8zM052cGJUT3dUbkZ3TC9lR2F1Q3UvOEZjMXMvc05RWC90b0RET2RHc21Y?=
 =?utf-8?B?K1ZtWkVoVWo1SE9pcFppc3ZOdTdIT3prS2E0dllOdGtsM1gwRWkzRlI3bkVr?=
 =?utf-8?B?b1Z2QURRVThCaGNmL0RFdk1oWmdESzcwdlREVFRheitCUlFsS2ovdy9iWjgw?=
 =?utf-8?B?RU5KYnJNS2R4RkRsVEY1eGEvcFEzcmhVRVdsNUNKZ3puQmJMNXQ5U2kwajBu?=
 =?utf-8?B?cm56Vis0UkcvdER6VkFQVXlQTlFWc2FHZzBadHRLMnN2UDgxemZtcnpwU0NI?=
 =?utf-8?B?Z253MGgwejNqUndtS2tYSXJaaXJCYkFwb0lsYjBJaG1EWTFUcGp6enQwYnJE?=
 =?utf-8?B?cEIrVVVHWHd6L2FXbXVmclR0YTVFNXJPcFFBTGxvR28wVlpRQ0x3bXo2dVN1?=
 =?utf-8?B?bWtCUnRMYUYvbUVWZ0lMcmJ1d2ZubUQyU1lkaWIrS0pCQzBWWWdaazRHUHhh?=
 =?utf-8?B?OWZTbkN4Y1d3ZDZmNkRQQVR3bWJ3VzFaaVBPaHdmMEdSZzR6TXFlcFR6STZ2?=
 =?utf-8?B?a2ptTE5jeEpQVExXdm5obWZlOGxxMGNlaDRYOXJHenNWQ3pTYkpOakhoL1Zk?=
 =?utf-8?B?WWczUmpCcVVETldXZ0VHNHl4aFUvSE5Ec0tNbm1kRzQ1M0RhZmEzVm5kZ2Jx?=
 =?utf-8?B?NCsxOVpUelJwUzdxbDJuRldiYTllVFM0NHV6MkxSSERINExCSGtGa0pMT3RK?=
 =?utf-8?B?YzdYSTNOWklHRXd1OWJlenMxdWVOQUhCUUdlWTVDSmhRNHNoUjVKUThaTzVS?=
 =?utf-8?B?ZmgzMEczMlppenc4dngwMWhFYitTTGZMRGI5ZVR1M2pocE5JbkpsSUNwOHZU?=
 =?utf-8?B?T0xwblVCdDZwY2tmS1BobG9NaURSUWpMS0RuMzNxQWR0Zk9IaTBEWmhNTUxD?=
 =?utf-8?B?NmRDMkhRb3MxVi9QQkNBanp4S2hIc3FoV3JHMmQwNm53S3VpMUFpd0kzN0Zn?=
 =?utf-8?B?SzVhTjZQamNxMU9pUzhmVzY5N3pwVVVHZWpVcnI2QWI3dDh4K0NPSTZPMjlP?=
 =?utf-8?B?UmwxZ0N3d0hyb3lwWEEzMkJEdStsZUR3azh5eC9yZTNCNSt6c0oyajNtektt?=
 =?utf-8?B?T2N3UFo4TDJjOC9rdFR3YWhtdWJzOEttMVp5ZUI0Y0l6aUlxOG5KRVhoK20r?=
 =?utf-8?Q?P8NpeDMFWLnmTm/nDgHloI/zR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bVDeLjzCRhQp/jc+IPmdZW1t20yE+d33bARjGmP3AfteWV9H2MVRKWPFSazeadoCi0e3vo6/zqZ0fxw3eCeatleJWwTIbd4HGAdKXekAEctPrfrmIq9px1Ae/wprKMX7buG52PIICDcxj0nw0PXUL+RkHkjvJSIUK1ibjx6RMm4TumU8Y0wy8BgdAotzDfTrknoBopGbpDJ4sZrM5gZH99HOnM6AKXQcGRtzSyy1NhRgGTcT/i22kbf1+9djTGd/nhyxL4ZXYt9HThD8vi8Zr0HYh7w9qFElFGV9enBW5VhCMtqlqoTKyCZPv7BCRoNOV/lgVY+GHxFLiqFIg19l3AxzMjqbwwImP+Yr8xO/FWL4HUCwhdTd1g1SKVcTre4kImd/CnxR0SRIGCVrhdlhLP0HJkGL7EZUYrvdoSJITdYzoqawwaWos3tH6xETTsLortQs92zHf+CnAuEb+f/2dUMEz1ijkERqqd8nFiiPJWgh/A6ovGJX7Oeudp9vger0N6mfH/MXPS9oXTc2LWtdziCS5Ec9YQKOt50l9mJmb1VFvoBYUmZI4ljj+yXLwrIfXyj3CtKZziQrls5zH1uhBZD2KL3n7cvaO6u42vsI6xitsSk5du9HNS9nPoBjx816zLL4MBJA/YdLQXdgyHVRGq8+1Q6IWP8jXlI5JyQ8Yzgg6qwUUV/D398pMV2GZ8V21dP+RVzqaR64F8AcyI1B52OkUoQis75LEOtRT1HmkNKLI92A0Eopi3vIHuN1Pj+/qaohwayFt09qxooHtwtZz5Rp75hfxqnUAV+0qAegQBxBkRJJeAjl/F30auWx2AKp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3014d06-8570-4fe1-e7d1-08db14dfbd16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 14:18:59.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzKGy6lvymqVmSo+8ctEkvuYg/aSdiVMjv/wrP1fQUNmHrMyQwF/LstkpLuuAWJ9Tm/gko6rPV6TN8KkNwcUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220125
X-Proofpoint-GUID: u06bAs_sQxnSX3LzjAYiD59Er3hmEtEu
X-Proofpoint-ORIG-GUID: u06bAs_sQxnSX3LzjAYiD59Er3hmEtEu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

