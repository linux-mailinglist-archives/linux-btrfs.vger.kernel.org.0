Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F06C5AD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 00:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCVXtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVXtt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 19:49:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530623A41;
        Wed, 22 Mar 2023 16:49:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJJ20J004434;
        Wed, 22 Mar 2023 23:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EorIeemTKIm+er0mu6zzCk9XfnCUjMDFG/SVy/l5xiA=;
 b=bx8fh2B6/wsBwyz7WKuoGpDhmkuMx10AxiZsLzFJugNJH+6/pQyQDGpslGejW8296n8b
 OnohwNWtoRaSD0NXvdxFMi+6OVIo7UXB6YvvTx+92+FgBCcK6xE5dJs7RSy3A0OzVQIM
 +gw1TVKEBR9XnyifNT7Kc1H1bkhxqur4MBWPI8HhcnE52l6LzUBTQCQKQgwI4OROyPnV
 LgVJUurP7laV3Jt8kvlHZizkFiH9/uCRREgOFIRQFU5xnskXGq7z02SOrUx7ypUTc38a
 ehpDmwwa+InJtjk9/h03/AZMlPdfmCwaRKnl5sMXIdSJWODuY60AKfBs4iEyB0L3g5j1 EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b27kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 23:49:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MNYNxm037682;
        Wed, 22 Mar 2023 23:49:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgbfc8de0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 23:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0MpyS2RSicb2zUbQqVfjR3uyjH1faF97FtS8YbvFHfvbb+ndfIa3QThdsOt9AnfxWCjhSckkZpBfcsj10v7jd8C6QwB7WL4ioRPkL3CvTvF3JgqDh3wkPkIgO1X7/eNV7tr4BLNPIByKEliTCHgxuqJ49faFp+SZ/6gY6TPF2f2eGkX8RyveJrNyIIUJk5A0/ChcE02v18UnwkV40rKcRRPnn3e2B8nX6SD5n//6/OU8xqJ+T/mmsTLxOyQU4lQ98yi+F2A1VocSniXaTW1PMEAZbwaXqSuL4/Z50M64Q1xT9/0XfTiPSCMx66jrmef+JlJg61HHj0/Ru50Gca6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EorIeemTKIm+er0mu6zzCk9XfnCUjMDFG/SVy/l5xiA=;
 b=hjaqFzofG0VruRMCpPQXj4SOWi+7j0Eiv2ACR96sAGxUHSQjptWRHGBouGjtg8lDYnvgALtCa0vzc/rpxr4ipd4m2LeNZE11ggWICLchXKSxfqhNFGDRh4xJVZ9sN1fXd0g/RcCgRpiBsewu/+wiPXG9Q7iaslbVc/E5SVDe4VB4juR0nY+FlDRQUgpLeA+MAZ+Jheq43nrkrTE4QfVbzznKUTTf8MbvQ/ZMvnfTUWvgdKpSN14VclCWdm/U3vJJrD1MclU94VMpc2f3MDWZNZ3xsKpSIBhTsiGTFzKQXK14L1q33YiHX3XebDsA3dAbwwdvrlITxGiB5sAXcfhX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EorIeemTKIm+er0mu6zzCk9XfnCUjMDFG/SVy/l5xiA=;
 b=hcLGMdAsdhGuZQPBGqqFRuqcpH/e91F5At7cVL8hK+Ryhq5FOCKnSW0mml5ILyybAo8HNpRjWDZa81WC4aQa7jip6YAnh+lWkiGl6y0cmciCkU15lh6sYB44HryJg+1aB37PQlJqF3dWU/paUfRxc9lKfuvI/MjvfMb31kJW4qk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 23:49:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 23:49:35 +0000
Message-ID: <acee1a74-d554-1bd4-8b77-2dd48c839237@oracle.com>
Date:   Thu, 23 Mar 2023 07:49:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [linus:master] [btrfs] 5f58d783fd: xfstests.btrfs.172.fail
From:   Anand Jain <anand.jain@oracle.com>
To:     kernel test rboot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Daan De Meyer <daandemeyer@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <202303170839.fdf23068-oliver.sang@intel.com>
 <1c807f47-70d4-14b3-7a20-8f595edbd99e@oracle.com>
Content-Language: en-US
In-Reply-To: <1c807f47-70d4-14b3-7a20-8f595edbd99e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: bd822047-abba-4b4c-f273-08db2b30176d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbiI4vNClKi6Wbmh1TvuctZwQAEyDzDuUjj9eYxavec9B5rQruLpBkrXONTxFVTVG4NS4wV8cmz268HS4aqblHyGohLLVfRduYCzJApuOmy1L0Xn4IHCK6rWkeIh1U/t3u3UkV7Pd3K7ZJXMFbwD6r8pXqLoT9eXGBs2oeTjTR4if+YwZ7w8r9sWbLQ7Ezl/98Bx4TTV5NY9It3RxWHUGkbDfMNrt/MNU7IcGNFqNlC7noOCJGZOwpX9kIpFVftCqjZJjqCCUx3l36vNSj/WFWnmThUnOHQMduKWkzRGuVYf3+Suvj3PNhwuMKTT70yjGRwkF61SQqhKSHhzxg7gYk6Djj59YNl9TNghVpOlJgnApLcww+E9YzSR0ySwEYUE06tCv/ZJD0QTOdjgG/hA5/C1plhxOSdPm1mDLf3jlUiMp/oFIxis/Rs2cjRVLEZy02sUnKA4lVmiNXStDq654pLhc882lrEuppszENHoEfgDskgr9D0/mGiyOcaU8ljRIJtZnVNEgLuFbKfZLEIABHAkUoDn1d9SKA4Vcn40O+29XnhNYl24sycJIukuHaSO1/Wa39nZQBgs+VuD8zGJr+37+VrEm3XjfIlk1qgp1tjbwCc/m8klORbg6oFGwrlTzkLi1nI6kr6fIzayncbmfzScpaIKzUC7rrGrBXAuV85w6DWs6JbCpn+LGnmdXGiJzSSsHXZru2cilds6NUMqhEUe4+PQWmC39wzSmKnQHA2tmxZe9CMBbn+E8yX1qWxmnGP5j9wSacG9ldhbPRxbcJFTqpMR+Fhnf/zq/wazyLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(36756003)(186003)(38100700002)(6506007)(2616005)(53546011)(26005)(6512007)(83380400001)(8676002)(8936002)(4326008)(6916009)(5660300002)(41300700001)(44832011)(66556008)(66476007)(6666004)(86362001)(6486002)(66946007)(31696002)(966005)(54906003)(316002)(478600001)(2906002)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1zb0VFeXEzNDJsNk82ek5kdU5QZ3ZVMG9Ub3pBNTlXMVY0amZMZUhLbGNJ?=
 =?utf-8?B?bW1ENlViTkRCZTZ0czJ5ZVhwRmNQVDk3dFlEOTY5dDFpcHNxZnB5NURMSnBE?=
 =?utf-8?B?YVpPQk1hVjRiMjdYSHBWbEdlQS8yeW0zZm5rMW5hMjBTNDlvckYrRGlZOW51?=
 =?utf-8?B?UEdlVU5CN3JGVDhHTFAvSnpyQkc5R0RiVDVmZkg3VDdBWjE4QUp4aGJiRDNo?=
 =?utf-8?B?R0VtbGlPelBCRVdoZ3hmaVJxcjNoRUttWENnZG52N0RETmkzaG1PSFBVYW10?=
 =?utf-8?B?ZTRRT243bUw4V1RWUFFFaUdiVGRRSmpvcGoxVTl6NVpUWTR2UWRSL3pVZ21E?=
 =?utf-8?B?WVJYeENmeDVZWTg4a0EwdlVTbE9pejQ5NWk3WStXa0J5eVZkcFhwOWZ0cmRP?=
 =?utf-8?B?dGhjaGdUMUE0dnBLSmRLVmtsTGY2T0ZMdnZMakVTbTZWVmVNNTBQTE1waEdQ?=
 =?utf-8?B?VzRIWGgvM0JZOXFIeHVhRVltczBJcnJUSHYxUWhRbjlyc09ZVGhaRHFQYnBO?=
 =?utf-8?B?dEU5RCtTRENGcVBCUGpYWkhNZXhPYjljaURMYWc2ZC9pYXBhYklmOEdQaHFm?=
 =?utf-8?B?emMvcXZJMkJKWHlHMlo4VU83UHQ2WDhvb3Q5Y051TUJWYW5iUDc2aG9Ra2ZF?=
 =?utf-8?B?dHI4bk1aYlM2WHJPb3A1MUpvdUJhVU9RVmpUcjlNTGVYNEFUSzZZUWVTczBY?=
 =?utf-8?B?NGNLc2VLcGQydi9TSnZndXlWNVJhK0RyRWlzTm1YOXEzMk5uYkQ4SEsxUUNy?=
 =?utf-8?B?LzkzZGVIQWlhTTJyOU1mcEhoc1JSbkhnem12TkdITlVvdnkvcGZOOXZIV2NC?=
 =?utf-8?B?Z2xCYWdvV3JQWUxCQyttSWxvRTE0N1BjQTlwbXBaSDY4WE9zaTN1Y0hLWXg3?=
 =?utf-8?B?M2pDMlplblhlbjMxT0IrelkvMUIvaGt0c1FFU3d4RFc5OHJZb1phNjBHV0JI?=
 =?utf-8?B?R2tTNnpFb0pVQ3g1WU5BczlDeW5hOTFwQ1RheUFMUENLYXJqUHFtc0Fad3pC?=
 =?utf-8?B?TE8xWDhDRk5vV3l0SWhoWDdVVjJjSWNNN25MdDVUanlzYzBucjlzYnFZc3F3?=
 =?utf-8?B?NjZ2Z0ZIMVM5THlYTUdMdVlRYXhjU0VmRno4bkJwelJiT1hkN1M2bGVRZzhG?=
 =?utf-8?B?eWkxeWZ0OHJXTkhlT2tYM3NTQTR2WW5TMS9ITTBjNk5Db3lLcCtSVG1HZWU1?=
 =?utf-8?B?VDhVWGNDejY1cWhFUlJqSmx2YkY2V0s4R0p5Y2kvdC9BTDg2ZFlrNTRHMkVz?=
 =?utf-8?B?eWZ3Qk5FMTZ6TmdHSENBR3dlMk9rL05QU2VadXQ4NXdyZ1pyVHhqRkttVGVj?=
 =?utf-8?B?c28xOUVSb1d5c0czdTdnc05mRENwRDV6emZxVStBdFpNRmFUSGZibjdQQ0Jh?=
 =?utf-8?B?U0FocDhoUVBLWnQxZkM0RGxzTGI5SnVHRzNGc1FDcHg2WkpKV0paRndBQnpO?=
 =?utf-8?B?OW54UmVCdDhDKy8yMExnSnc3Q2xyNkNJOXR5cXdISlh5M2d2RmtWOFRYK0R5?=
 =?utf-8?B?UFl3YWl1Z2l1MXlHL3ZNZmhROHhrMWFVZEpJbTltNFBualVZeTJsRG1oZkZJ?=
 =?utf-8?B?VTdSdWZUaUZhNVVWOVJUSWlJQlFXazVVWjM0NkFWVjVZb0JSaVF1T3FxWFho?=
 =?utf-8?B?SVZvMnA5b01hRUhMRVlJdlBHZ3ZvSUtyYlEzb2hobFRnK05Kcit3RFl3TWNN?=
 =?utf-8?B?ZkRYUGNQSGxMVW5Kc3FVZzRqMVVXK0ZmWmx5OGFXZnJMd0M0cWhYTWRUbXBl?=
 =?utf-8?B?RTlaVk1iNkl6ekRvaWVuclAxZWlFNW5qTWhTNDM1MWcwb2ZxWlRPdWdrVGJK?=
 =?utf-8?B?KzVrd0tONnRTYlBTRVFJWmpCU1hYeEx0QnFTRVBtM0dmNk9qMXduR21ENVJj?=
 =?utf-8?B?NzFUTG9KU2FvQnl2SkdBR3hBVE1jcFM2cXZNaEtuYjBJQ2NXRGlkTGw4VVd4?=
 =?utf-8?B?ZGxtL3RBWDVVOGQzd0NWNjQvcFl0Y1ZUeTBCVWVnNlYxdkhXUVAxdiszM01v?=
 =?utf-8?B?Y1Zhd2lHL1ZOckcvNEtLbkxqRW1IelNtT29LSmVwTVZ0Q3hHZzM2SEpRVWhs?=
 =?utf-8?B?VzgrYXRRSnlFM1g4emxnWmtNQmFhRmh6eTRDbGdTRjZjY0V1YW82MXBVV2Fs?=
 =?utf-8?Q?3AYva8tnvYJCJFhvVsJoMyenV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ZxarycPO8e9QNYzsZrKdpegGlQwbywY/3LIhcA4eu/oFqALmD5D8KF7xwrUolgWoXNl8kIDCcxoKgt3JvGfscICy2nMNdMaOFJivT5/NdC9vkbBs/XvhIQvHsP+RIRacunG7czqebNR6ew/Hr6e/R9itV2F8xlX7PdXY7VTJvt4fFe41eFaYZyPH4LjzjKp9dcnnAikt2pGwndinJfaVq8iamfRsgUHhN3W5/XSj8z6gWmp13ubxmqG2Zzfeu0jLt8R4XQIt8bkglnzQYffaomVZBcflaakZ0gOqwEmdXHQpH2w4W4FXGtcn7vgllRJhnaLfbgAt8l7GpshoI0XpXmZe3TAKOCqB9+4Eur4wmUIicoSSbSPyf47lMt55w1KB9qK5J+SSKV76cFDSNq96LvADtgQUjFap5c6I08VNH4RFtSGhio98FvEjTvDXOyl4CwKbII+I/c0n7EGcZnb/4KMyO00Z+MHQ1i6Y1N5Dt9KvDen1Ne0d7pWbrIlvHrhv3v6nXV0XlVF9nzUDM2C00yrveLnQhrJfUvzJmOOgQzE1f4xL6Z+R7U52zkjADzBD7otO4oQeQgt3AARh8tYNX7f5gFZQY/IufGof9csHOXeQKIQykgvgOrMOeWNB8yNwukdcybgzuOJ4evsDlQ90R8ywJde+x2alJvOgCUt0O8Y5tbZ+w/uiWZiDI1EfXi63ICEWHhKxEGeOVzOfzOuIyPNQEf6hKOLHRfy9mTuslKO22bvdlLqEyH29if/TsfsN+mq2FR5cS+JAFKJxCGcRcPRYvMYamFZygnWVMA6z0X/tjZQV7I3hruMglvcOMlYEFqeNTnNAC1RQPAlg/1G/0AcIpoO0rWbzTBzzr3C3e17bffX7IndJGYG1oDQdGTQhFbYRm6dDXKw/iDtL09GJZPGWdt5slh55ejXnfVi904=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd822047-abba-4b4c-f273-08db2b30176d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 23:49:35.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/bo7na7066nvYcWzSoSbl4DYK4BHyd2toQT2D5rvGca/L/R8V/VFKJjEsOk8D3ZCpmPLrQKGia9O2G2bZ/RTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220174
X-Proofpoint-ORIG-GUID: bS7efX1SeLczyEvcObohLkKSr_uYflAr
X-Proofpoint-GUID: bS7efX1SeLczyEvcObohLkKSr_uYflAr
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2023 12:14, Anand Jain wrote:
> 
> 
> On 3/17/23 09:17, kernel test rboot wrote:
>>
>> Greeting,
>>
>> FYI, we noticed xfstests.btrfs.172.fail due to commit (built with 
>> gcc-11):
>>
>> commit: 5f58d783fd7823b2c2d5954d1126e702f94bfc4c ("btrfs: free device 
>> in btrfs_close_devices for a single device filesystem")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: xfstests
>> version: xfstests-i386-5a5e419-1_20220926
>> with following parameters:
>>
>>     disk: 6HDD
>>     fs: btrfs
>>     test: btrfs-logwrites
>>
>> test-description: xfstests is a regression test suite for xfs and 
>> other files ystems.
>> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>
>>
>> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 
>> 3.40GHz (Haswell) with 8G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire 
>> log/backtrace):
>>
>>
>> we did this test on i386 and we found the issue doesn't always happen,
>> on both this commit and v6.3-rc2, it failed in about half of tests.
>> however, always clean on parent commit 519b7e13b5ae8dd3.
>>
>> 519b7e13b5ae8dd3 5f58d783fd7823b2c2d5954d112                    v6.3-rc2
>> ---------------- --------------------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>>             |             |             |             |             |
>>             :14          23%           7:13          33%          
>> 10:19    xfstests.btrfs.172.fail
>>           14:14         -27%           6:13         -17%           
>> 9:19    xfstests.btrfs.172.pass
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Link: 
>> https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
>>
>> 2023-03-08 04:47:50 export TEST_DIR=/fs/sdb1
>> 2023-03-08 04:47:50 export TEST_DEV=/dev/sdb1
>> 2023-03-08 04:47:50 export FSTYP=btrfs
>> 2023-03-08 04:47:50 export SCRATCH_MNT=/fs/scratch
>> 2023-03-08 04:47:50 mkdir /fs/scratch -p
>> 2023-03-08 04:47:50 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 
>> /dev/sdb4 /dev/sdb5 /dev/sdb6"
>> 2023-03-08 04:47:50 export LOGWRITES_DEV=/dev/sdb2
>> 2023-03-08 04:47:50 export SCRATCH_DEV=/dev/sdb6
>> 2023-03-08 04:47:50 unset SCRATCH_DEV_POOL
>> 2023-03-08 04:47:50 sed "s:^:btrfs/:" 
>> //lkp/benchmarks/xfstests/tests/btrfs-logwrites
>> 2023-03-08 04:47:50 ./check btrfs/291 btrfs/206 btrfs/196 btrfs/192 
>> btrfs/190 btrfs/172
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/i686 lkp-hsw-d01 6.1.0-rc8-00284-g5f58d783fd78 
>> #1 SMP Wed Mar  8 11:05:36 CST 2023
>> MKFS_OPTIONS  -- /dev/sdb6
>> MOUNT_OPTIONS -- /dev/sdb6 /fs/scratch
>>
>> btrfs/172       [failed, exit status 1]- output mismatch (see 
>> /lkp/benchmarks/xfstests/results//btrfs/172.out.bad)
>>      --- tests/btrfs/172.out    2022-09-26 09:38:15.000000000 +0000
>>      +++ /lkp/benchmarks/xfstests/results//btrfs/172.out.bad    
>> 2023-03-08 04:47:54.134026209 +0000
>>      @@ -1,3 +1,5 @@
>>       QA output created by 172
>>       wrote 5242880/5242880 bytes at offset 0
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 
>>      +_check_btrfs_filesystem: filesystem on /dev/sdb6 is inconsistent
> 
> 
> Thank you for reporting it. I am currently looking into it. It appears
> that the device is being freed after it's closed, which could indicate
> that we overlooked something at close, just a hypothesis at this point.
> 
> -Anand
> 
> 


>>      +(see /lkp/benchmarks/xfstests/results//btrfs/172.full for details)


Hmm, I'm unable to reproduce the issue. However, it's possible that the
O_EXCL open for the 'btrfs check' command failed because 'systemd-udev'
was scanning the btrfs device at the same time. I noticed from the dmesg
that the 'systemd-udevd' thread was running [1] at some point. I'm not
entirely sure if it raced with the 'btrfs check' command to successfully
acquire the O_EXCL lock. If you could send me the 'testcase.full' and
'testcase.out.bad' logs from the system, I could verify the issue.

[1]
[  337.769932][ T6408] BTRFS: device fsid 
8dcaa8fb-b317-4e13-9e04-e9b63fe91948 devid 1 transid 6 /dev/sdb6 scanned 
by systemd-udevd (6408)


Could you please also attach the full log and out.bad file for
the test case in the report as shown below?

  /lkp/benchmarks/xfstests/results/btrfs/<test-case-number>.full
  and
  /lkp/benchmarks/xfstests/results/btrfs/<test-case-number>.out.bad


Thanks, Anand

>>      ...
>>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/172.out 
>> /lkp/benchmarks/xfstests/results//btrfs/172.out.bad'  to see the 
>> entire diff)
>> btrfs/190        15s
>> btrfs/192        101s
>> btrfs/196        163s
>> btrfs/206        4s
>> btrfs/291       [not run] kernel btrfs isn't configured with verity 
>> support
>> Ran: btrfs/172 btrfs/190 btrfs/192 btrfs/196 btrfs/206 btrfs/291
>> Not run: btrfs/291
>> Failures: btrfs/172
>> Failed 1 of 6 tests
>>
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is 
>> attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml 
>> file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>>

