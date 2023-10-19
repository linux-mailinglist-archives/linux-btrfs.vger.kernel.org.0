Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F007CEDE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 04:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjJSCOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 22:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJSCOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 22:14:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C61113
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 19:14:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IInBRY013667;
        Thu, 19 Oct 2023 02:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2+qDP8RzuHYWN4P+rDw4G32DDi38LyItKAqkoSLoyko=;
 b=YDxTobQTL/MuH++Ht1rAovJGvsxcHZNrEdMBNIKxGj1bgbULmKfbc5MT05kRGBHETWUx
 QMC0iB80eHY6syR+J71oHL94THGVFq6pznT/50p4Xm41y46GtBy2ylH3P3mF3XfGaQL5
 RiQFHjPibXz4YvjO+FOStndrIBabv5AYASLlCPxu985IUaFwdHbenSoryL/Nwk+0CunF
 e5fG2y6ctjZn7o8hBEVZ/H+aDt+ZQlfU37dzUvfetmPrvf7Yma/FCL0FsxNoaeFxpXOm
 n08b+PGXNDvSGzxP9P0fkMRQOTiFiQfFFkXwCpFhVmcTnNVGiHsOOFv8ryg+E2VlGMdc 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1d15nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:13:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0mhIh015181;
        Thu, 19 Oct 2023 02:13:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1ha62v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBBQlMEFwGewrxRFg7fz1xt4ACHCjmpdVwRnjyRY3Grd5rTq+JFrXnHvQuSqe/NKVl8UXAPRbdJfHm8v7Yo4QRlCwqp03JaAzVg2xj7ttzN439dFCIogn3sCPQGd9EHsajWqLtEmof+3zWdD8RVdUlzxpcnCGJ+qhn6deQ9Mi3zve8gAfIekDQZR1GNtirFu7dnfllD5EtN9z6dZqlJv6unnh8vMcykXPazi0YIcrRPus6RYzggm9mLpZn5rtPkHxTgR5ZlvILPDwVKi5T+kDSdOdR+d5kOTB7/n0p0tao5+ZfToS2NuhEsng4Uo7XH/IHmrF5lGdECBrOeV3gCAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+qDP8RzuHYWN4P+rDw4G32DDi38LyItKAqkoSLoyko=;
 b=Wpn+s5eVMRuvESDvj2wEmLoLiDX5/nY5hXDY0GJtwxkhjPTUK80ODJbtVb/KZF2Yp2UK/qsGebIURYFfW9IRxdBov/37trdzuI/hBiZPAAMJfIiGZ6lQOybvU23a5wLKhgW8cFRT/2iXs74KuRdG1zCGsCmUOExINMZD/P35bdsNRFCZGQv0tLCB1VE0cw02WRtQhyK1ImyhyPcaTRGt7goW8kF/e3LCUzWZS/oK0iLGojXZJ1UtzVzX9QpJWvLuQa5WbYdhn+X1WjwzC+DWxyzOKH2+LtsO50DR3qmpsLbFwne+2zV55kuHhuOf8aO0/c4c7iFsM4hQYSjG/LxTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+qDP8RzuHYWN4P+rDw4G32DDi38LyItKAqkoSLoyko=;
 b=aBIveveqT6TFbDm9vhLFp6H66/c50jrp8yIgS04B+IJebKEjsO9//woHA28dJJmLxTuOTySxHUUWgyKKV+10AzHXCSqNSGRdrE7k+Dx+Uhu1mjOAzy5eUPyGhUof4OiKTHCd+3GRml9dOjI3WYPlYK0q4m7Q6NHWaTq2zS9+Yio=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:13:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 02:13:53 +0000
Message-ID: <2dba310f-03c3-4d86-971d-2f9f94a5c9d9@oracle.com>
Date:   Thu, 19 Oct 2023 07:43:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
 <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
 <dfc68882-ac04-4b11-9ac6-505341e0517c@oracle.com>
 <2a729b71-3f30-d99a-7129-4e13841d180d@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2a729b71-3f30-d99a-7129-4e13841d180d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: b41c5b1f-a15b-49bf-16c8-08dbd0490a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtacyGSfQc22x/RvzVCdoy1mnpDpVLZ4xPMIgOYtspGcDnGQv/nHhtGtopyqmQf2WNyzvPpqofbA5vRAgrJOfPYzbEOkAJb20HRB88EJbxdDlLNucX7OI8+T0ZS8fUAApkhuyohO1aC/6Nw3ow0+Inn1tA3eZxxD5EiRM2W9uIPqeTCV92ALI0TFIrYGqaIcQWo6oalhVlLhjYIW0kIRFtIbwUf7tW9+e0bg6jjDODUrGFhJasJbfkqtRD6bEd2DKfS8wobhroBuXt1yvdE8HR/o9C/jBc7Sf0Vn0y+kxYpK/MmgJSCCrBHWI6cBAVMAA0TKtNR+Wqb9gaPDqQd3DGAzSQqM7mi3IOG091tgDERRnyf7yIRkfvuXkO2MECq/oHnPRbx3iSmAV0de+ZATn9q42pLjGwE0zB2gqyTAiLpoDlXS/x4f6+uc31Jr6hOv7Z3RBH4WRd5mdsQVu/EQKB+Cv02dJQSTmsG7rjDVtiFO0wYfG72tBR7YGgrJHj9CJjs+9lv9Ays7WtKw4IMiUOWEUvkpQv8RJJifdxqobUYe+Qp5xhmTTYaEFCm58Pwd6m5eSnGWiX38oPUaEUXWi0vII9xt2X4R6byNq1tHmbIOvr0GgTVoELBYUpK0OLj35FRLRF8hGalzOkeQvrmKWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(4326008)(8936002)(8676002)(5660300002)(31696002)(2906002)(44832011)(4744005)(41300700001)(36756003)(6486002)(478600001)(2616005)(6512007)(316002)(6506007)(83380400001)(110136005)(6666004)(31686004)(66946007)(66476007)(38100700002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk0wR3E5Z2dnZGxsOERsUHlpaHFaUVByUldJVHVIRFc5anM3SzB1L0JCUmZH?=
 =?utf-8?B?UWxuMjNyTlQzbUprSEp5Qm0vUG5EeTZORWxpdVoxV1ZKcHIyOWlrYnQrMU13?=
 =?utf-8?B?ZE1Sb3ptL2YyRlZBaFIzdlIrTXlQRzFVQlJvVmNWMTNHTlRSRlpucExJbG8y?=
 =?utf-8?B?eHlJcG16SERxV2oyRmRucVVXNlJOOUtjcERmdk8xdGliTkREc1cwWWd1eDRq?=
 =?utf-8?B?QXhPRi91cTJaTHgwTjc4QkJQQVVGZ0pPTWV3b21EV3E3NmlyWFNIQXBxaEU5?=
 =?utf-8?B?emJpMWRLWnJaeUl2VTc2aGordjBlNXg5N2d0MFBzZU5BVXNEa3pPbXdWdGMz?=
 =?utf-8?B?RUtRd3VDY0RYcVh3bGdSeUNyRDlGU3JnYmF6dTFmV0NHVXZjYXlRUVd4a3h5?=
 =?utf-8?B?UEpMTW00N0dWZmF2b2hlZWgyYTlZbzFpdTdUNTdVME83TG8xSTZsMS9OK3lN?=
 =?utf-8?B?YmFORnhiekVLR1BNcktKQytJdTJDZFkyOGhwVnF4V0xLT2Roakl0OXJyRkxt?=
 =?utf-8?B?YUVORENuMzloUVBJTDNjd0M0ajNTa1JmN0VaVUhaZU1IcUNOSW8wRmdVdjBh?=
 =?utf-8?B?SlpxRUt3QWhrOFpSenJ1TGN2VzhZQ3hnVWZrMU5kcHcrbDhUbW1kM2xEL2Rx?=
 =?utf-8?B?QnpSNXFDamkxU3A5amkxd0RXTGVScUFRRnJWbjFVcFphWWdFbHNOb2RWNlZs?=
 =?utf-8?B?bWVtRGtyMmNIZFJrUHJvYkYvQk1sRmZUdzhzKzVhcFlhWFBVam9rU3BLTGFJ?=
 =?utf-8?B?OHNnTjJoeVh6dXNJSmxXS3U5cXNSbmdLaFFHZS9jQ1VycVpicXFYb3BUOTd6?=
 =?utf-8?B?cmliQ2ozdTJrV21PNTM4Z3o4RzJ1NnZ3TkV3bW5PV2tnVFdMOVlFK3dCL0I1?=
 =?utf-8?B?Y3BCakgxc0VNUDhmaUdnRnE0YllOWjNPM0c0ajdEdHJJNjdHMUV0bTBNbWl6?=
 =?utf-8?B?NjdqbU0xdEJseFIwNm9wT3czOGJCQXRNWTdHZFJlOCtqS1BKcDgxd2hDUk1W?=
 =?utf-8?B?Tkx0dWRTSnA4bXl1WTVzSUtId0ZvZDFSNkE3TE5VWkpqcGRWNGVpNkVyU2dq?=
 =?utf-8?B?R1hnSEZ3S1I0SkpGUmsyaXlrbzBSdHNPL25KRmhBWFA3T2xxTTRHaWt1NWcy?=
 =?utf-8?B?TW5kYnc5Y2dOSkV6ZkM0cFZ4dktnb0dYcjR5TVQ1NkMxWGppNGNZU2xzSFVY?=
 =?utf-8?B?Rkkrc2hhMFgybndoM0RmOGxJNmlXWmljSmJnRzRsQzlMSUo5ZnpadDF4SkUr?=
 =?utf-8?B?TWJQcDlaQTJtQTk1VWVMTCtZVGJLaUEvTklVcjEyNzFrbnZyejZqNmRHN0xU?=
 =?utf-8?B?S1puZ0U1VHgrekFUUndMMVJCYk5POHhpcjFrNDVOd2pyK0tuNDBXQm9za2k5?=
 =?utf-8?B?dEFqLy9nMTBrUitTY1kzYXlQYlBPV0VibituM2E5cHFpNldYTy9JaWV2bGJM?=
 =?utf-8?B?SHRIVDRBZHVvOHRtdkdPZ2JKdG1jZWR2S1pkMG5EQmlsaGd1VmRTbytLS1pO?=
 =?utf-8?B?aHNaaG9DSW42bHpXcGVXSXRLU3BBeGlIZ1R4N2RtdGhPYUpnWURzZlhWQWJt?=
 =?utf-8?B?em9QWWxwRTh6eHNBR1N2cUtRbFY1YlhzS2p2bHorNURIT3JFSUtyNit0Q01K?=
 =?utf-8?B?QkJSY2FEQmJpdXI4L1BoTGVBaC9oSkxSS1hocVNRRXI0TVJ3Y2lJY0xhTjVx?=
 =?utf-8?B?bExwNWxaaFhhYzRaenhHMjVONnhBbXRSYXRyUklrVUtSQ2lrdzU2SXZBbUFH?=
 =?utf-8?B?b3lBRnJBQzJNNUJUNlpRSWhYMnJVdFRHQjlTZDhwd3U5ZTRiY3R3c3d5ajB0?=
 =?utf-8?B?VHdmdTgyOXlNU1BLc1E5aXFCWXJ6SHNVblZaUnJMc1p4SERVT0Y2cFBrTW9Z?=
 =?utf-8?B?RHVWRlBadjhoK3lCeGhvZDdZY0M1WDIwTm9TSEwyOXo2MFo4YzFKT0F1TlRT?=
 =?utf-8?B?UEtrWnhRSnBhQkhKS1RSM2VWYWRPMEswUm1oZ1dxRXMvMXk1Vk1CYkZseERF?=
 =?utf-8?B?Q2JJbXRjbjRjNThyTGdBcW1Tb3IxcHpaM0NObzArWVlGS0sxQ2pXVzJyc1V6?=
 =?utf-8?B?d1BqcXVZbmdrNnNSK1dVMU1ibzNoM3FLR2ZiaTdBWFFPN2pMdWRRRE1sNzVo?=
 =?utf-8?B?dDMwUEFFbTFCakh6OVlwck1CNkhJbDd5M3RZS084RHQzbWZidGRJbGJIczd4?=
 =?utf-8?Q?/1FvwmnrcTXpq+UKsLkNVIzi5cJuvti7ocZXMW4co4oE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fl411AXAmPkBIPwWQLQ6oITK/kukr+Vbpvm3AOY+LBaVCza1gv1rAcYyiUt/svMOWeO9xJJ1E+iFeyM0PwWVRqmt9DaSSxtoS9/znm7RHFQQHoYqzbpsJTpbGegsDrVba4Heau8Ck/kR7GCurnplhX1v6UHs0Sic9wQb82PWIxJPRBoiUg3Ny3r6WrAfWpmCeNP/SBSCHiYKHnemEuetjg0/eKdl7C4tXeRi+NnydjcwJvjFjkjqh4YseMWUQKiZf7dDX3AI9kHx1Jx7mpFeOtF0XG7morvZW7byJNDhGmJx3NURsUtFHL1R99EXgmkl+tQQFccVf8i7nPiwOK+po52Rxgp5t7AT0EB26FJnNIrZXNXxBl39NHL762/r+CW+dO1U8vHjX1xxWqJmNVQo5ygBKTOsy+pAUpPywkSNItmgPN3utO/ESL2dWDl9ulPZLhDK/iSIC7hppo4cIv6/9ic+LW+PNDvkt9/XakhX+UHQSjJedkGvhlvWSHEW9xjoY7/pBejXLA4Rh/sGvOcvdUFa3ROsxWflwu412YHOQknPZT5h9AuhrwJEKUFZDycITFsTq3ZwfmPcsUxyn2HnxwwPuClavAw15DxA6YqnClj5guB1Ef0s+cqfLz/F81sZtjCj/PKhlwjEIVI082FxCkivYg3D/fxSb1Pn46xVPbGWzV+fXbPQWQrGU9OuUTKmwQPCvhfLMvdPNmB5Bp4Hw23JZTMdvNJxa8cOOLATaZXcixVPfvZ2p+CnhMv3Mhzc7YNz0a78436KqB8pS1ZuBaF5QCZ5zYauwNHiktqZH7R9kuwRRGTjRhSJmFMAhBtn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41c5b1f-a15b-49bf-16c8-08dbd0490a3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:13:52.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kd5nWG0w4KnQSBsdahzS8Nw0tTfgMKGsY/HHpTN9ud1uDKMwrxTmn99INSW1pvRRuxK1mVIycDYIrIRme+JONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190017
X-Proofpoint-GUID: mErrM5nin06y6WuOxlnNlgT15aoBI8mo
X-Proofpoint-ORIG-GUID: mErrM5nin06y6WuOxlnNlgT15aoBI8mo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> It does work! I'll test more in the Steam Deck, but so far seems to be
> addressing fine the use case we have...

Thanks for the use-case validation!. Is there a way to turn
your use-case into a test-case?


One remaining challenge is with 'btrfs filesystem show' when
cloned devices are unmounted. Currently, only shows one
cloned device.

We could consider porting kernel changes to btrfs-progs to
display all devices, (perhaps with a random fsid). Please go
ahead if you have some time to work on it, as I won't be able
to look into it for the next two weeks.

Thanks, Anand
