Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFF780830
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359036AbjHRJVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359044AbjHRJV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 05:21:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919D3A82
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 02:21:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I62MtF024544;
        Fri, 18 Aug 2023 09:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EV9m3q30xPbOdQY7/Gj8p+LJSn04VNiybKsIwHCnsUo=;
 b=n+hkDTNiMrt2za28A6m93lRnBAkPWLcHYpSYvajCyvRzoCyQjibs1PleAQ3dpxRo2amQ
 xjeL++Vp+jTXepGlgFkbuTo1qvm9A9ibDAWPnGBSaeRUmioPiXMW/3MXxqLPXaMDX2o3
 3jZPlGwh/Mm4i+obBFQRbUbpf9Ss7csht34QK6pYI8NWJ0ncgpeS3MKZJnb9kCpvqlnj
 uy+yvldSB7p4LjnwnSkKDPseDDOkeCxjOieUbg9W1G9dgVThsf30Tp9huOJ5Wgb/bDfV
 eiZSku5nI+JnKm/iTyxPwH2fnXB821mzFgoy8p/gqqXpKq4EwMKP4UeYkZCAJzbdQrY8 Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y33fu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 09:21:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37I7g7Ko003743;
        Fri, 18 Aug 2023 09:21:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexynq40h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 09:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYT/m+j9kqjeOl6jtUDUWY0ZyNpC17tvoi575z1vUSFW7yXGljtT3sxPj7gRmLNv1akgTvwNOdsOCA8qFgVgX6T9QT0VLGJmmeDfmKKfFhlubo0h6uBwIW8Tro5IVO2HGxWb3M7CaZGmaVdjpy6vZRlZJWkgffiOEKy7vZkcVrsI85Jx4I0muh+e+qcaX3SwizjTFXZzI8xvn54r96V6cJSLPrCeUPWUSH12XJLlrBKtG77K9UGg8JLgmNfogc3DhvLczwyNOD7q4iiMK1ef0cHpnKQv34mFS3EN4wH3B7r3e20s8kBlk4rI31m549A47ZEPeaMYNDnrc15+IJhFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV9m3q30xPbOdQY7/Gj8p+LJSn04VNiybKsIwHCnsUo=;
 b=G0lAiQ2rNWU+Q+dAlEAbE6KHDCkDl109WwOR/Ky8u3x8/HT8AtiWRYJeYhedNqWWb+gXknpN4Sx5fHEGQ6MJmr+QQdkyBuvtQemQerY8Y6bhoCvXE5MueqRP4tN1+mgNeh2M0gCsSp20nq7PpbmvIzZl/qE6PQsOD/Zufu+hwIRPkB6FYOClPpftwHshPG8t/bU6GO5cjaEA1jh7dIoZfBLJrLL5ZtJLAj06JBNazJv4s76trf3fR1ElMEG4LDD5eW64os4o/bx+3FOhFQvuv0CsrAjZzvZAVZvBfunVTCffvhbQOZT0h76Py53JxrAdlQwnOKEGAI7PUfLGu0CbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV9m3q30xPbOdQY7/Gj8p+LJSn04VNiybKsIwHCnsUo=;
 b=JATvPxK7foiYtClFD3T+tswpOS5CHvzIrULxUJO0puG8DChqzYuw814nPyn+U0Zbc01D+0Ab40bpAVo3/x6ZhhSIinrO8pl9y6OLZt9WxdutAuyKsC8qtqrJleqmJ5kaYzK/T3PqA+wqACHWsAxs3h0D/+gCZX4SXctUQSjWaCo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7491.namprd10.prod.outlook.com (2603:10b6:208:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:21:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Fri, 18 Aug 2023
 09:21:13 +0000
Message-ID: <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
Date:   Fri, 18 Aug 2023 17:21:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
 <20230817115229.GJ2420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230817115229.GJ2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bef4f-defc-44a7-54da-08db9fcc7777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXyX5DHhLbQ3iZLx3bMSXrjz7YQbsxPEM3hbDT0CHihh1YH59LVVFqjcj0b3wXFZ4SEMQys47L43ESu3wJgfX75I9pXFSQ3SYbrLS51lvQBFgI2Xm7YurSoTBzwYwWKonCulMit3WIpM2zoJeGDwCT7C7WykEqJfZ4gcxVu8+7uCKLJTKhL6E3WYi3gRwN+7rR88BX84yII8YMRhS0EF0r+uWgNz8ifhm0xEZRP12MmhotwDK0eMGkdMOuwvN6qxQmowcnpsKoCJ4dYiokTNZnQQGxNiktgwkMkZtfyDVt3W1vDsTPbfxowOUj7bM6U1CeFrwWB++MpwU/K7imvtPbvja12nTZikGJCXqijXRLx2yh6qpMuIhQ9t2vjg7PhMMLlpwt2Nw0BQNciESmgQNtX+3JIwgEuV8eqxisY9M/D2PG+pYEQlZMg0TCJlIJS0Ja5Tl5YOkDk8fIaHP0EOICb5cU0RfBQoJaTFCPI6KraiRwyPBCNRZu+W8LnAShndCh5uMH6znjZx4ln6B57pgve9/12cycd9IuQsKOjqNuWK9N8mMjiS73kNDTgDLyTIANzLwDFHCLxUyJH6SSV+Gxh0qZCvPsiK18iQSiRj/oZ/7UcaZVdknsabWHV74/+4MmVJ5OlqeuJ5jCMv780euA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(2906002)(83380400001)(478600001)(66556008)(66476007)(66946007)(6916009)(6506007)(6666004)(316002)(53546011)(6486002)(5660300002)(44832011)(2616005)(26005)(6512007)(8676002)(4326008)(8936002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJBcWg1QzR0bC9PaFVnMGFnVU5BTkYyUDlyQXpNeVNJeEJCMHIyd2JWZ0pE?=
 =?utf-8?B?akl1TFU5aDNqWFpxUTZiL0xVRm90a1JMVFVNWjcrcWovb04yaHRyVURmbFBk?=
 =?utf-8?B?WmthNDVpNTdKVDFhQ2dwclkxNThkNE9CZGUxOUlIWVRBY1RqOW1JT0hHZnVG?=
 =?utf-8?B?Y2txalRDV2FJdEpQSlZ3TUdCUlhFYnhhZExTV21PTWhIY0dEUjlIVlBwWnNL?=
 =?utf-8?B?OG1pZmhheFV6dnlmYVc3VG9la2JmQU1MOU5QVm9uMWdSV1ZGM1pmdzFHdGo3?=
 =?utf-8?B?em5sSEtBUUFCSkpLU2dULzFyRmJhczZVRXFGaXhHRnk0T3UycG0reEJGRVBl?=
 =?utf-8?B?bGxFakNiekE3WFV1ZTlPOUQ5RTJVU3pZczM3aUs1UWsvd3Y5LzBLNk1meFJz?=
 =?utf-8?B?YnVHQXBBdHZFV2YrZ21XOGxUVFNyeStYaUxyNmxzeWNJR3BZTU05d3BkUkZO?=
 =?utf-8?B?aUZFa1NTY2JVL2t0VTVSZkd0MEV2M3NQYmRtenRhcGZzenFIc2ZBV3E5QVRE?=
 =?utf-8?B?T2kwbUR2cEFtUEFpSVJKQXN2RXc3Nk5nYzNSRUlOZEp6WUVsWUV0TDJUcHZv?=
 =?utf-8?B?QWQyOWdFQmpNM2txeXc0NHA3ekVpeEVHdk9OZXEzNE1KT1VFRXptbHg2MzJS?=
 =?utf-8?B?eWtraDFtWUlUMS9lTFpVNTlTN2NmUHpWZXhGRU02T1BGWVhtOVJSUHFpa2x6?=
 =?utf-8?B?RjlxKy9qOGt6T2M5Tk1kTDh3VjRMYVc5N2FVMHFRMFEveUo5TmpVVFB0Lzdv?=
 =?utf-8?B?YlhZTEp2Q0dKam9tcEJXOGJaYTFUcmptZGZRNHNVM0JvSXVQWXo3dzREc3NV?=
 =?utf-8?B?QWRZUEpnS1ZtWHFvSkhFbDZoOVlGZlRhaFdFdG5iZEc5ZVg2aXFFekgvNlQz?=
 =?utf-8?B?YmlGMyt1SGtLYW9FOUplSXBBSndReERQZmgyNHpTN3JYVUR3VUpERDVnNnJJ?=
 =?utf-8?B?RFJkOHlwV3pJZDE2WlFMazVEMVc1V3g3UWE2QzVPQnJVUjgyMGN6SWdxR01E?=
 =?utf-8?B?c2RSTDcyMGlnSUtuWUxsdzIvOE1UQjlncXVTc25aUC93eTc2RmtnT2lmSVJN?=
 =?utf-8?B?ODhVSm85MjlSOUs1L3I4YlUvQU95ZFMxMVA2ODRjWW1sNjZwMDlibGVUUnRU?=
 =?utf-8?B?WkdDUUJNRUhlL0s1V2xIUFJGMktFaVJZaGQ1NUJSN2M2cVVMUjdSeWlnTlJG?=
 =?utf-8?B?ZHpxMi9TVmplTEhxK3VUd3RIUlhyWFRrOFVTcC94OE5YWkxNelJSZEU1TWlz?=
 =?utf-8?B?ZUcyeExSYzRmanN3YUoxSlhPeUt3K2ZDZXgzcWRJOXZWc0JzamJsaU1kY1NS?=
 =?utf-8?B?eUJNNWtVRlBFZDRjdSs2bkxYeUNSYTAya1U0cXpQeEJQcVAwZFdIa2dOOFJP?=
 =?utf-8?B?czFVOXpWdlp6TnRmcjczV29TOTROdWgwRElaVFlRb1FwbHZpVTFVN0hQYUJm?=
 =?utf-8?B?OHZadGZ1R3FiTHVZRG45OGhEV250OUFSbWM1Qkljc0V2Wk9kUlRSeEZWZkJ6?=
 =?utf-8?B?aElqWHNIbEtlV0tPWDBtczRpcmJXcFNJdDVJbktabFlJQVJjeWhJY1dmUnlm?=
 =?utf-8?B?amYwZWhyYkcrRzB4RDc2TkxHRmRiN09WWTR1QUZTWU4rVitab3VFa2M0cjho?=
 =?utf-8?B?SitNTmZVZHl6UkRyZGJ1Ly9nUlkzUHRKdWVieUMweC9FVjN2aTNZZ2d6Z1Ft?=
 =?utf-8?B?UGM4eVE5RDJuZms3aUcvTG9uYkJiWGdpKzk0SWtlYmU0dTlSZ0VBdHk0cWJK?=
 =?utf-8?B?bGxnMnR4WFgrZ3REcW1LNEp6ZzI4R0E4UElYWjZRaHVXRjRNUGhiS1VFbURW?=
 =?utf-8?B?c1E2NVNORzl1dlBNMlNqZG5adjFFNkFlVGZCZ2h0ZGdMTTQ5aytzZ3ltV0tM?=
 =?utf-8?B?M1l3OTd2UnFMMEJJME1vVDdyZUIzN1FqVEFOMXJBVjZjUWdNb0d0YkRjRUxO?=
 =?utf-8?B?RE1MYzN1Z1ZtcDk4aXEvMzNjZk0yUTdnUHQ2VlBvS081RHFkejQvc2tDcnI4?=
 =?utf-8?B?K2tlc3AxSyt2bzVyUEdmdm81SW9EWjd1WVAxemVLZ2JXYXRZNlpQVFhLUHMx?=
 =?utf-8?B?QnJwbS9wYlEzVXN0N21KQjdXc1VCYjNTV0c1OC9MSzBuZHYxWER3WllRMzgy?=
 =?utf-8?B?QUZDVlI3UVo1aTB5MHljQ3BId0dIVDlPMFYzZUR3WTVDVUZXMVNwelBoc2Nz?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Bf4wc8/oMgvpESmOlwzdssTCVi85mZQALDsXyGr2eWeGEYTz9reC6CafOZ+VH+nPsWweMcqbPygUdCxnOlWNIAV+vhEr+oo6Qq4+Hach6cW+EjlzKAOjpupsP7ZMOQmqMSEoUojNlxlIGHQ6PonqOwVDcL/M3Y/3uzBr6q9oXr3s6drPI5qv/LC1P/8W/LlmNHiHUc3AIIOPKdSQIgmyfuZcwG04x7bPLUrCuOuDZBG6C2BvtIDwZJrUIH13yvXcnJ7NCUI1FLhNCSa1G8uSGgmHZE7W/qFnaae7ptoY6MRWDBs97FPj+vCNNtL1rI4oMGR4l6HWXeMkY80k/QvUoEI8yFeB8nUiGOCWtIilMagFro6SF9HEWs59l/8jWUmNQhUSNY3Knxr5Pz9MAgkP4D6N+xYyg++1sAwU/aYgoqvGF0vcSPOPDsZYrHlyibDv9M3V2a8EzI+phRxD7iyRN6nuabB5UvmkEtnC/yPovEysPLXY+xSSibH6leLQ7DEPIaAAEYg5BL1LpSkx8kS6rGDIvxM1JobIvLadfw4TeyiGt/8WEAaldBH4IS8EB573xa4L8HGK5xxRv4IxDeHhj12FW11WDYK/+z6lp1BkU6DM+r7fVC8e0MQAMQd+glI/NurDeqYEsO2z8lgDVV5eun8a+UgBNogsPcYQWor1tYVJ2LMTeHERl9zGc17lTuPW53fc4Y8QOFXJcWM0NsnyVyhOPXbhBDq7QBtPGkA99iqPaEX8ecMqtPgGRLYWSDmn0MVw3Vx/Umngxx2iWp6aCok4NGKhxNjFi6XcU+Bg3noWEjNcOlmHFnE/xG3D89I
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bef4f-defc-44a7-54da-08db9fcc7777
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:21:13.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT0BlS36Y+d0f77ZhQ77A6etihSWcnwWg7vFVWIWHtpVnmvXogoHow3dJQD+HU5FXu/QR/wm82nIXfiAtjMAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_11,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180087
X-Proofpoint-ORIG-GUID: P1taJgcFtFsmmfVeDFnnw6GUg4SV4pAR
X-Proofpoint-GUID: P1taJgcFtFsmmfVeDFnnw6GUg4SV4pAR
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/08/2023 19:52, David Sterba wrote:
> On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
>> The btrfstune -m|M operation changes the fsid and preserves the original
>> fsid in the metadata_uuid.
>>
>> Changing the fsid happens in two commits in the function
>> set_metadata_uuid()
>> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
>> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>>    resets the CHANGING_FSID_V2 flag (local memory),
>>    and then calls commit.
>>
>> The two-stage operation with the CHANGING_FSID flag makes sense for
>> btrfstune -u|U, where the fsid is changed on each and every tree block,
>> involving many commits. The CHANGING_FSID flag helps to identify the
>> transient incomplete operation.
>>
>> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 flag, and
>> a single commit would have been sufficient. The original git commit that
>> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for changing
>> the metadata uuid"), provides no reasoning or did I miss something?
>> (So marking this patch as RFC).
> 
> I remember discussions with Nikolay about the corner cases that could
> happen due to interrupted conversion and there was a document explaining
> that. Part of that ended up in kernel in the logic to detect partially
> enabled metadata_uuid.  So there was reason to do it in two phases but
> I'd have to look it up in mails or if I still have a link or copy of the
> document.


On 18/08/2023 08:21, Qu Wenruo wrote:

 > Oh, my memory comes back, the original design for the two stage
 > commitment is to avoid split brain cases when one device is committed
 > with the new flag, while the remaining one doesn't.
 >
 > With the extra stage, even if at stage 1 or 2 the transaction is
 > interrupted and only one device got the new flag, it can help us to
 > locate the stage and recover.

It is useful for `btrfstune -u`
when there are many transaction commits to write. It uses the
`CHANGING_FSID` flag for this purpose. Any device with the
`CHANGING_FSID` flag fails to mount, and `btrfstune` should be called
again to continue rewrite the new FSID. This is a fair process.


However, in the case of `CHANGING_FSID_V2`, which the `btrfstune -m` 
command uses, only one transaction is required. How does this help?

                 Disk1              Disk2

Commit1     CHANGING_FSID_V2   CHANGING_FSID_V2
Commit2     new-fsid           new-fsid



