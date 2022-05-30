Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1B537377
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 04:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiE3CC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 22:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiE3CC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 22:02:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC453EA91;
        Sun, 29 May 2022 19:02:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U1c3W1026550;
        Mon, 30 May 2022 02:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UwDLl0OxEM7HA/4elVqq0kUJKi9i6i/BCB2xZAF0Pis=;
 b=iL25MYppqqNYp0cVZMoLIKydDV7cPXxVI/BBpESc/mNN53FmJrfbMhmhsOQcCbuOjbdK
 BgC6h8JqEVczpn5u84caj9xJfRHo+hOs+3z+1k7aKMHOZ+NzjEAbKOeyRH8selSwvPgw
 ug0TyCPVAYaSIKYLpZtOHhDPbdlqCC9+q6+bGO8qDWCwdzzE74epZq+oM/OX/W/7cLrN
 DtQTcGDlwBKEp4NYdTkYofhYTAmDx7O+L026E2EaX0kTzhgg07MwcDlOT1ZAx5VmTr1l
 U/H+Vb1JjMyUDMMqxslnCXz/9simgcDvF46qoQ95cSCnwU1mnqjPN6oDXZqkWvxNRtEq 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm1jp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:02:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U21Wvc008940;
        Mon, 30 May 2022 02:02:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kdgtmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 02:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J328u/jvTlAOX8kW+duS+JRyYeXyd6R3mS2KI3ZDzBowpQDdeUsOK4yih87zoOHfnDT3w5UHsdMKZ19kwhTlTXbMAtug8+Dfbno9fRorGsfhNIovEtbmV/bz7bk0YNWtY+3ncXnPXg6ptBSFQhKlizLfWpvTM3Ye6FbQUPqJxWYmf1H6np1WWGEaw8dpZ+ZF6PSG2n7ACvAJiF7tnl8Hvu2miNEYWhU8WWDS9FaetRBtxxYv4TaeJqfL86WuoHFiCKr6JrbrT9foqXvVQuXefNYdl2TqJ1TdOEM7Z4z5gHdfNRYmURJknwsq1dMONCSpAfFLUGuMeSddbaXjX4JrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwDLl0OxEM7HA/4elVqq0kUJKi9i6i/BCB2xZAF0Pis=;
 b=fEJGbb8cBGqVEbqbHTE5CBpJBwbQ4Om5hERlzAHx0r66mMl9ce/VPBSMMmSHPcpTXhrmDDO3256VeVsQfQaTNNOJwDR5E94uZAcSn1mQ/Z40ZsCvtVQ3OpOQ6EVs6woztULz/bnMxY/xFtItFFwJ9DItvxmCR7sf8fhRQUwSTzzEcoO7ykazv8Wi4DD6BBaufUekyefvg1nMYF/xLvhYMDx9HeTFUtkTm6X6x8fN/qByMa1soBL/iA9wvT86glw7oBAFoM/rKDXaveU1soU+FZix/kvMGAhznO6g+KLe/CAaok3BfTxEW91k0qsXqsCJRCcIxOImyJfYastDA7OtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwDLl0OxEM7HA/4elVqq0kUJKi9i6i/BCB2xZAF0Pis=;
 b=mRDUBKk0Ym6k6W8+ksa2CoVM3TWhm1fSAtE/tiHYaNdHdB3bCEgevUI16KvWUSAAiNm7KZBI1DMazmaGPtIqKu/bDrkRNEAzGQB07PrDpfxEYmQc1Z9sTswzfpJDOcqvDuRl5jAcinDU4w+Rlt20xuRa9mKxCtjrwvZXbbnGV8s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB3959.namprd10.prod.outlook.com (2603:10b6:610:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 02:02:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 02:02:46 +0000
Message-ID: <3d8d64ef-5f22-169b-3375-d9b6023a21c5@oracle.com>
Date:   Mon, 30 May 2022 07:32:35 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 09/10] btrfs: test buffered I/O read repair with
 interleaved corrupted sectors
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-10-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c414791-82c4-4fa4-45e4-08da41e07d50
X-MS-TrafficTypeDiagnostic: CH2PR10MB3959:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3959A22B744EB5E3DBE67F6EE5DD9@CH2PR10MB3959.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2PPd3/mj5ve4AABHe2r70Bkv+4XXe6Kj8s09l2NWz9xdY4eTPCHAn/kOlVpdIWno5eDItzmIN5MQoGqRlxb23homxRCuSwIQLY9dX5jlw2b/GUsbNAPEL0o6eD2d6yoi37nCHBKqdKrA+ZeO+G7MmWQjZCHN3M/NP6xGL9TwUsPIdfuRmiDN9kPYo3E+ftjRVHhDE5/+1bRasQpGwbEwlDNlPKFBiMSNaNAojuveTOiupQQ+Nfh7KnBosPhLF/UwzWY/3Uz13Pjq3oBZ2sIQlMYSEeNiuDUjXDlywVKtAP3bLu02kE/A+xn4uambqcUBMv/xOCLdgcI+ZNSqSkCvoFxcadNKS+Tyqg6Gd6RRiIJwmb5ZHcoo91wDlk9P8l9RKd0+4aIyDYUBBpvNw/dvReCbSCFRgZNKf4njQKe0GA+ws8bxHK8QoJrT9LMl4j21vutWCSfm3xpbXyyoWV8AI3PuF+oj3sdU8C23HAVlEA16ejJmJe9vAmbZDRb+prCX3MLSjolfLoHoZUTuRx4yLaIjj5HOkeiDpGECyBqOYQUF8J1XsAVPfDSRPojKboZQo6JQ2XDRG/fmBdHAq1uP85CZ79vyG76J5BGRQHYqu2MpwqLQI1DYu7H7+0cIL+zBWQvdFl6w06RUMEmB863U28vPhLfPrdFnNvzyZVBDAZTKSget1Yh4ntl4eGCQ10dzD9pPEATfbCMdUcrHwIQLkaXf0REvPCSRLPC/0h0RVX3cA4mocYuxIJfMV6UhV0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:la;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(86362001)(6486002)(38100700002)(2616005)(53546011)(44832011)(6666004)(2906002)(30864003)(8936002)(6512007)(5660300002)(316002)(31696002)(6506007)(36756003)(31686004)(4326008)(66556008)(66476007)(83380400001)(66946007)(8676002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWlrUGF4Uy9DbmJBMzNUb3pzSlU2QWlJalBNd1JsUHRsSUxiTHFxTWxiSEhS?=
 =?utf-8?B?aUNDTTNyWmJYd282SXZ1NDhQa0ZIZnF2c2QzUXBkUTR3UkRZNWhzNkhJVFQ4?=
 =?utf-8?B?Y1RkSDhINlVFZjE5SW8rZzl2MENmeHpBK3p6aHcvZlY3YTI4TW1oQ0tMZnpj?=
 =?utf-8?B?U1Q3MlJXbThTTFZwZ2Zxbm1odTlEcFoyQU15MXlPR2VsdlZta0tTamhjRy9a?=
 =?utf-8?B?TUx2WVFVZktKY04vQi9Hckw4b05sTVRXQmRybXJtOGxDT3FvSHpGRSt5V1dp?=
 =?utf-8?B?YnhGOWNnaVM0MTVpTG80OFRVYUNYSWgrRC9Ranp6bEdJRnd6cXVob1VXcE82?=
 =?utf-8?B?MG9LeHJCUDA0ajhlQWhHcU9QY09Ia2N0OWlhTFNsNjNQcUhTRzZBaEt3VVpV?=
 =?utf-8?B?MW5HdlZLTzBxM1E5WWtvRWtlYlI2eVgzelY2L3gvaVBreDFubEduayt3NmF0?=
 =?utf-8?B?d1c1WlhINzNMWWZEY2d2eGUwRVptWGozU0Ricm5FZTFKTjdNU3FXR1JIeTA2?=
 =?utf-8?B?STNuMDluVzhnQjA1QlozcnhhS2ZEaGNKZ1N5WkdFeFJvZnpvaHRBdURMZDhC?=
 =?utf-8?B?YnE1N1BwNTg3M2hhbmZhTnpMb3l6VXVQd1dtTlBPQUZtaHFnWHd3Z3FSaHlO?=
 =?utf-8?B?L284Y1FlRW1YN1hBL1ptd2p4OVZvTXFyQmhJb3AvS09KN3FUVmRuYllRV01H?=
 =?utf-8?B?U1ZWVUxwNVg2clNuaE9lUWhEUjJHREVJUUFaT2F2SEsyU2trQ3pIWHFYNjg4?=
 =?utf-8?B?QUd5VVJLWjdjeFF1ZEpNRDJnZE5yZFhuWWVCMlZkcmpoUTYrbG42NU92bXNi?=
 =?utf-8?B?cDBBbzFOeHdTVGJnSGxTV3JnekVWQTJ4T1I5elc3L1dvM0prcW5lbXIrSit2?=
 =?utf-8?B?eUNLYWNwUnN2WjhsZXJaZDRpMlBzYkpRL29QaHlOUVBWd2dTWWFweW1xdjJz?=
 =?utf-8?B?QWU2UnhVQlhwN0FqbGRuQWRGZm9yc1V5d3BrVitzUkR6blNOTkNlVk5wbnVS?=
 =?utf-8?B?N24xRVo0bkRKTlcxMXVIZ25SSHlBWkd0MDh2bEVZdk40TVVjdll3eHdEbHFS?=
 =?utf-8?B?SDc3OEs4VG92eXQ3MTQ0eWM0L2ZhTGxWWFFoRUtxZkszRmFHR0E5eEY4MWpJ?=
 =?utf-8?B?eWNHTTgvL1U1L3pHOTF6YjJRQUc4OE5MZ3pMYlFnZkRrOHMrTWdXRGRYYzk4?=
 =?utf-8?B?clJBS0xYc3Z0ZzVCRjlWNkpQRGxxMVp2MC9pdE02TFAzOVNTckhNcGcvVlhI?=
 =?utf-8?B?alk3emRjRTQwNjdLbWw2Q1ZHWk5lbVYrbDZTMW0wRXNDT1JnYlMrK2JiTWlo?=
 =?utf-8?B?OUtZbWNLNk9JOVF0TklabnhoZGFLbmdIWUdObzE1d2FtbzR5bE5jQlAzM3Z5?=
 =?utf-8?B?WThOanRPQVV3TmNrdFRRa2FiU0tSVlhKLzFWZENDWVJlL2wvU2owS3lnWEFz?=
 =?utf-8?B?azZNY0U3Zyt2S0ZUY3ZqTGd6Y3JTdXB2bGlpLzZnRjdiTzJIN1JHbG5oWU5n?=
 =?utf-8?B?K3FPdGtKUy9leitqRnhNbzh4WmNsWlp6UExHMTF4KzVObDRSZDErRHJSZWtP?=
 =?utf-8?B?ZWZrd0ZqYzF3Vi83RldPNzRhQXBoMzhud3dkVktFZC9CRDJSd1pQNkcxWitn?=
 =?utf-8?B?ZEZIMC81VUdXTFFxc0lHdHM1QXY4Yk41eTJHaDRiYVE1NHEwNkF6dHFyQnZJ?=
 =?utf-8?B?RmpPUTRyWUF3WVhsUG1BRlRmNGZFbUh0TlZGSm5WTW1Qb3RteVFJZzZVZEpN?=
 =?utf-8?B?MVUya2N6S0dudUdkZGJkME9xL2lYT1FJbU4rbTZwd1lDbGJEUU1BVml3U1VU?=
 =?utf-8?B?M0owMnBxNHorOGtZd2tmTUJIZUFqOG1zNDgyRytIVEx3MGNPdGZpRm5pYlpk?=
 =?utf-8?B?eWNmRERaL1FJdUhXNlhDeHNDNWVJb0VVbEdJTXJydXRBdHdTdmg1TzFNaXo5?=
 =?utf-8?B?bWtlOStVS0x4NUdFUUpKUThuOVNYd1RJLzhUWXVWdFJLMEY5aTBrOUU1YkNi?=
 =?utf-8?B?T3pPMDNrNGo1TUo2dHNPNEx2bG5DRCtBS3hyanFKdGZwODNjaTNqeDRWbCtM?=
 =?utf-8?B?dXlQVDVXVXFUd3VuT0ZVWG9Fd045cmx6VUlVaWNMUFp3NUNSTHVHejhXVUVE?=
 =?utf-8?B?TlBkL3BhQVNXS1lXKzEwNndnWTZ2TXliejB0L0pUaXh6c0NqL2FJbUsxd2Nm?=
 =?utf-8?B?U3FqYjBVWUtzSWRHM1ZkVTZQUUVyNnBtdEpOb1c1aDZNT3NHRWZYRTJxQkhG?=
 =?utf-8?B?WXNvUXVoOXo0UXdUa0VnTFQ4elI3amdja0Y1di9IY09XOVFPYWxZYk8wTVVx?=
 =?utf-8?B?aEVIQUFzeGZaKy9XSHhidW10eTBFWnpUWFNXWEtMQVo3QlQ5VFZaengrbkdh?=
 =?utf-8?Q?k+28cSr76T9N9drDcZxJBmEew40cNlO/obXTVfIwgMj4g?=
X-MS-Exchange-AntiSpam-MessageData-1: 0CAfJdDdPiETmW5V1Vdq3m4vaBvCdS4fhUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c414791-82c4-4fa4-45e4-08da41e07d50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 02:02:46.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiPi2+SWsSJcOPQq4meBqe+jjKeXNyilcqVUZcT76AFbvRK1lhSaJD+s1vTFBflkjBTBZn65esuEqkKx2xYkNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3959
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300010
X-Proofpoint-GUID: BYSc_Trst7EM3L2YnIXoWOJVMdv4fapR
X-Proofpoint-ORIG-GUID: BYSc_Trst7EM3L2YnIXoWOJVMdv4fapR
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>



On 5/27/22 13:49, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile and needs to take turns over the
> mirrors to recover data for the whole read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/266     |  93 +++++++++++++++++++++++++++++++++++++
>   tests/btrfs/266.out | 109 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>   create mode 100755 tests/btrfs/266
>   create mode 100644 tests/btrfs/266.out
> 
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> new file mode 100755
> index 00000000..c70e4b2e
> --- /dev/null
> +++ b/tests/btrfs/266
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 266
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair interleaving
> +# errors on all mirrors.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt 4k in each copy
> +echo "step 2......corrupt file extent"
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=$(_btrfs_get_physical ${logical} 1)
> +devpath1=$(_btrfs_get_device_path ${logical} 1)
> +
> +physical2=$(_btrfs_get_physical ${logical} 2)
> +devpath2=$(_btrfs_get_device_path ${logical} 2)
> +
> +physical3=$(_btrfs_get_physical ${logical} 3)
> +devpath3=$(_btrfs_get_device_path ${logical} 3)
> +
> +_scratch_unmount
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
> +	$devpath3 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1 128K" \
> +	$devpath1 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)) 128K" \
> +	$devpath2 > /dev/null
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 128K"  \
> +	$devpath3 > /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair worked"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
> new file mode 100644
> index 00000000..fcf2f5b8
> --- /dev/null
> +++ b/tests/btrfs/266.out
> @@ -0,0 +1,109 @@
> +QA output created by 266
> +step 1......mkfs.btrfs
> +wrote 262144/262144 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

