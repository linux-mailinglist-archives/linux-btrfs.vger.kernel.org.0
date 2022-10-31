Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89EA6141F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 00:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJaXuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJaXuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 19:50:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037F5F6B
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 16:50:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNhvoT016727;
        Mon, 31 Oct 2022 23:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tcis3WAi5OHN2Sv1Cz0b552yGGV+18mi9AMUREe67ns=;
 b=MtoUNwV1Vjc75rxBgv0zBRlhX4hhPi0NZcfnyb4xbRiH63NtJt/rsq73KhmY20xBXksM
 ey8zWPXMaobkk+J6ZuAHNF4B2uRKWasMqyhDuBJ4B1bMiFRN0l2X5tA834VpcYGq/ElB
 vZkB5u0Aea0x5cHDa9CySwiyTmApTR7/KPtYNYC8+rRM7vK++YjvehKDiId1xEll2t2M
 nrZKWeu8eDIskmiFC4rBf1E0MxQsqnTyI834+u8EHRWlLrD+72wBq3cEgXkj9ITVmkgI
 rXHAekcxcauZhiiWF5EHOsPK/SPkmOd4bANpkaoEsRHZa2jD2UCgrCGaNJMZUscXHjWi cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussna3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:49:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VK5qUm032935;
        Mon, 31 Oct 2022 23:49:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3swjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSCuM2TW4qZLhJI807yIWjMEB0+qYOQ6dP7r/+TDPEBn5CtMQRtDr8AGguxcW9EcLXMXotmsnosYtswbcchLGt6ULZYziK7EZi8wEKb5aQ1rS4Lf22xqcrSXW7tAptEsahIhBReLv9orzrLv2rw6twiSrg0NcJMuoxUu0WXAo7jYp0yezIuMlaCBezzXIOmNJqk6f1IHl5Jikt/GNOzsLCUjxJiH22mnpLS1odva5G1BMek6w4A3pmGUuzUZaLoZS4tra8JiyMR+Z5HEAZOBymIAtb8pwXpxsrTP2tO2yC/fP2B3+NGK31VuKCSoJknKW5CvrSOKLcw42ghcXV6m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcis3WAi5OHN2Sv1Cz0b552yGGV+18mi9AMUREe67ns=;
 b=TLyA2PCst8aAuP2Xv7ybhf9B5cSQpEo1vLyPiCaA2u1hYawSsBMHW/nONlSqBTMcIOfdtyTsk5JIkyb+g8e6Emp4MIyLCzae5WiMxA1dgMYfRWOhFHrPtQlJXgsI09Dmo1KmcLqkotMF2rSVPZxxutLPW4RCWq6Irb4i0K34kpBlM36X1XE6zBx5hMdmi/b77n7c/wP9t4JRgkdug8voAFP1U4j/iQbxknKA7E0QIWVbVoGGJTZT8ffLjzmRDImt7t8wIMDJAjltd8z1/NshnMKPys0AbNBFFNrF89AbQnXQeCmQTg1HQ1pTImZpteFnSOKmY24gfHaI10qdXGW+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcis3WAi5OHN2Sv1Cz0b552yGGV+18mi9AMUREe67ns=;
 b=CqCG0N5HTDxDjDmtsoOLn8IbLlrlZNwsn24OoOTUrobj1NE7SEClO7cOtfjfCOLHYsQM8eMrNyPjnuc54jKjjKuO2OBDoDjmObFPBB3fQr6AHw7JNVjDxjZzDhRhuH6Req8D7SBdsp6tCosX4vAja1wf14CdbD/8dEnOWaEfyhY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 23:49:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 23:49:55 +0000
Message-ID: <4deebb69-69b7-cfc8-f4bd-2e00525f756a@oracle.com>
Date:   Tue, 1 Nov 2022 07:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/4] btrfs: zoned: use helper to check a power of two zone
 size
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667244567.git.dsterba@suse.com>
 <1e9e2015a56fb48dba859dff85f3eee1f69f74fc.1667244568.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1e9e2015a56fb48dba859dff85f3eee1f69f74fc.1667244568.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: f266053c-4f49-4b80-237f-08dabb9a9c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AukApY0eF1x9P0VaygbNo1udzkJ1jb3g3fBItwi6miKvoQ9zxPdJvEy0OIxEGCnmMcLG7St/w+SDfcU5tKqjwJCbmMsMzY7zo5hwXobzYv75Ou1IzaE2OgFdnL/ewngVpQaqojkTWyFst9Pps9Na2e8NDQqztgbtwsxXVf2Sux7g176IEydgv4wHsuKvFlVHUU/eNVY9i0FGku7Gvx5dR0/WDOypGB+5dT6crkZVhQc6700hTFHs7iHrSf8EYTqwczUxTOPLl0Us31CTW6VtaIkmpL5zIxIs8bY4FLTkbO46B0RGxfsVsv+UXuIbWbHnf0AZCh+zvkmIPVlBmQA2sql5ht8WgR6aVxoXoIhJ1aGZuZzusBSfUxg2nT31jkK4uIccXnX3r3aRSifvWeM6lRcPoBmOm10n65WEo7vOWUh4zctR0i+czLZfF1NxpH3WhA0ZY49CQxB/DnClwKPXNBjxfsWutGsfjyWPpb2cJ6eIGtmVPOJGKG4666e80f1K+SKInVgkVf/3ld0Bimo62RatBZNkTne1Qj4qSCd3jZn1ySGt9Eq2rZaJE1m4sMup451NfZJbxjBGQfBVL7N9Nq5rV2IdeWJxwFRtyiPyNwZCO5puK/YEuf527B5/JYPgmj66oQCwkvjmwOBWgl3x55XoITTwq/dQlEUoCvEFTHoFM+Tq5HAT1yoV/Sm/+cmbPikMsC3GqYMIBv15jLDi629DCx4XsjHmuAN3DZop2scmklfYobno8Gp664POfaydbdZOgXBB8mFXbGPrIMkZ4EprqwPk8Vknv9oALFR7y0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(2906002)(31686004)(86362001)(316002)(31696002)(53546011)(8676002)(6506007)(6512007)(36756003)(558084003)(26005)(41300700001)(6666004)(38100700002)(66476007)(186003)(2616005)(44832011)(66556008)(478600001)(66946007)(5660300002)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVVV0VJdStZdU5ZT1lYeEhUQlgydWkvV20yei83K1BaUFBRTUk4SXZiZFRu?=
 =?utf-8?B?L2liWWY3eHdPQWs1WDJGam5HL3NrN3dGK0gwckd1dE15TEoyL3B6VUhWZ1VS?=
 =?utf-8?B?NTNhUXgzNlQrQnljMkQ2dG5FRFo2Q1duTDZzaXhFOTZQSzNORXRnWFVYZ0t1?=
 =?utf-8?B?enZjVHVjOTNEV2YxZUc0M3FrTGJpTFI5cFcxSEovVWJJWGoyM05FY0VLVzU4?=
 =?utf-8?B?UU0reDQwTlNnZ05aQWxtK2s0QUVtT3huLzNDN1BIcWgvaDE4ZElweWpaZ1JB?=
 =?utf-8?B?SkYwWGhlQ1Jkb1NZTXVsZUVNQ1BUcEwwZG5jdE83cHRXWEpBRjNuR3ZYbWFk?=
 =?utf-8?B?V1Z1KzRvQjRkRHJqNWpsaHByL3Y5MTZtWVMyTWdveEcvWEcvNkVPM1RSbTBt?=
 =?utf-8?B?d2s3elQ1QndaWnQ0RGdLeHVvMVZ6TmM5Qk1IVElwcXJLcVQzOXdCbDUwaEdL?=
 =?utf-8?B?emVEYTZxQ1g3cUFuWXp6dHNTaUkwT2xPaE4ycjE5WmtEdmJRd3R3TFF2b05i?=
 =?utf-8?B?aS9TN3VRQTczaHdmdmRjVm93bFFQMnhwbDhZQ3RtK2E5QkVRK0ZBd0lUeDNP?=
 =?utf-8?B?N2MzL2xERW0vNnFQQTNyZHdHUkxyUzQrNjZDcHdVVXpYb0QveEVWMHNYOExl?=
 =?utf-8?B?UHF1SWtsa3hsNlgwK0VsL21sWUoyNGJHQ1dxbXQ2SVhEQXE0eUY1b3NQY04w?=
 =?utf-8?B?d2d5OE5WUzdMVktGZ3YyTHFheU5xNndodHBIQzZJYm0xRHcrTzc1SmZOaStE?=
 =?utf-8?B?Mmlhcmo5Ti9HVkRQTDQ3ZnZyMUNkVUVxei92cTRFU25KenYrc1o5ZU5aekhV?=
 =?utf-8?B?NjBWL21RMHlITjZPTm1GdFoxMTZXTE4rSUdZckJYa1o1U3ZYeXhWVkNZekFp?=
 =?utf-8?B?ZlRlRHJRT0szNEZJS3RhN3FRN0ZwaEhCVmp4TW1raXJPeEFTMjdzUjJJWEQ5?=
 =?utf-8?B?ZXRMOHlOSkNzeFFmeFdiSjFZMFJ2ZzRmdUJpaFcxTGZwclgvOVN2by9GOUMw?=
 =?utf-8?B?MGtXZ1BSaVBibUw1NVNIZ3BBUUpMamtkRjRITXJaRWZ2RGJMM3g3TlQ2MGor?=
 =?utf-8?B?NWNNSlVlZnE3NjRKTFpjaExCc0hhSk0rMGt4dUR3NXdwMnVEWWtQZDlmbU41?=
 =?utf-8?B?LzUrdDlNSm9qWng4NnlTcUJTM1B5MXNWb080TmFRdHlVd25INnlCRFBXd05G?=
 =?utf-8?B?VmN4cFRPRGNieHJwZ0x6Z0NHTkIzRm5TbmFjMFAzbVhvU3dMVkxzMk55OTNU?=
 =?utf-8?B?NC9yd2pnNDZtMXQ5VVpPWkQzYlhmbjVDUWtWVWdvN1BEWlE0K1BtRnJYUDA5?=
 =?utf-8?B?bUdCMGtMaHNYcHU5eWc0amVTVnJvWC9qWWRRaUVtV0RXS1J1amRTcFU5MDlT?=
 =?utf-8?B?MGU4dTNZdnJYSkZQSTNsVTRjbGpqbllRUUxMcTg3N0tRNzljZHFtUkNrMlJq?=
 =?utf-8?B?NEY0cjlTVEMwK0FpS1VYbWoyRXRGT3VjeWIrbmRhTEVVa2tyRHVsUHN4M2xU?=
 =?utf-8?B?Z2YreVFNTFpydVZMZStHbERhT0MvNkMzTWN6NlVVVjJZTjkrZEZKeS9YYk8r?=
 =?utf-8?B?VnVTM3NWRGQ4ZzQ0MytacG5adE9keW5KcUt4ZGNsSjVRd2MrR2w1UUxVRmYx?=
 =?utf-8?B?eTk4NkFjMWMxanZrVXFEVVhWa3oxWVNieklLVVZ6cE5oSlJIb2pPNTVpSzVw?=
 =?utf-8?B?L1pGb3hRaUVTSjZncmZoNHRkRVhlK3NScVIzWG5hcjdoczBZY09reDZrMmd6?=
 =?utf-8?B?cURWWjNYSGRvZ0lVbW1Db1NrS2hoR2Q5MktJeThuMGF6R0RjR0JhcmJMYVUv?=
 =?utf-8?B?bm5pN1VUY0pxYWxhbVRDRTNndVRkcnRxeTdRTjkyb09BUUw0OCt2S0I1ZkFs?=
 =?utf-8?B?Z0F0S1p2WmVHaUU2SS9XY3RSQ3cxTUdiMDVkbjhuY3pGQkd3S3lUNVRGQ2p5?=
 =?utf-8?B?b3ZvOTBNOERNbTVzOU9ZbFV3KzZ0bWNhcUtxd0FBVHRiKzJVQUVINDViQVJu?=
 =?utf-8?B?TDlGbmErei9OWjdXZEdqblFRWVhOeFNyZE9PbmhlaUNLTFA2dXBRVGRxVlFY?=
 =?utf-8?B?VTFXMXhITEhrczJha0FZVzRRVzRUN0YwalJlb2pXWkRENGFNTDBBTmo2THdR?=
 =?utf-8?Q?GtbohDnfndoLHOzY1WkUR7+io?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f266053c-4f49-4b80-237f-08dabb9a9c33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 23:49:55.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49HRqNpzKWRRrIOGUVXrx3I4kAlTe3Zzp5rWGURbaXszUbaqL3XufOEW96dAdUaL6NddgmpUCwFfVm3xR+ySYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310149
X-Proofpoint-ORIG-GUID: FKy5PIkFydmCJNqtHeUBIr87v2DICF-9
X-Proofpoint-GUID: FKy5PIkFydmCJNqtHeUBIr87v2DICF-9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/11/2022 03:33, David Sterba wrote:
> We have a 64bit compatible helper to check if a value is a power of two,
> use it instead of open coding it.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

