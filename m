Return-Path: <linux-btrfs+bounces-1385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D782A755
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 06:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01142287F3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 05:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800823AD;
	Thu, 11 Jan 2024 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WACHhTqR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="scHcHAQI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5F20FA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B5TN3P020870;
	Thu, 11 Jan 2024 05:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vGP4S4MMTMMlCwTZ9t/wNSHKNA1jra7gqEIR2qD5Ekk=;
 b=WACHhTqRgjhfEWLvhd3aLwYX2qGCcCDso3+ZGSjxsQEuRrJTAd1Oy+M0OscU0svJjWf0
 7nZvAe26ppxIbwwq2eSz6e8P4RL3JDXTSMTjaIsl+42Jipn3D6epbSVUZkQ72B3Jx6vy
 sW7FoUJhP/0ipK4+ts1432hQ+Qvb+d2xI3+gP+ctpRHSgLWdYRHk1TJgSK2Pl6WGwkGb
 GgEX6U/dafdMSoDlaYkQC3Bkea7xIR8b6zP4K3NeBxJu5Ct5E1YVQ9oozgzp/3dwE8Ry
 CW5xrGa96pwG1RWxFZ1OEOtxgYUi4dhvctrS2xfU9Qv2KE5goLNf2/M5JXRFUD5idKyz og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhx8q18mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 05:57:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B3xraU013971;
	Thu, 11 Jan 2024 05:57:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfure3xf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 05:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ5rK2dagtxOHmBX0A86NUSL4hHEFr42utarY+6z93p+zyfjMEuc89WT3SJ8rfzpA7Kyh88YqZV2LXki7EOa69ihal5HdW7VaK7CQIgmem0mnPu9EFzUEWbNgvSO8p15/nJRiXleI1FwJdEZEwBNvcGQXs/PaAEbpT8cSEn25ijVrpQnPxPpFUcGe/6x3uh7dbFeqOgwe1aOiwLEZiJpBzej7lHwlbeUbh1/+wG3+xxSxzdASRza8Voy3yoK5SzHy5xq64dMt/0aN3j6v4D4AFBdh6rddA5kQzMYX+WPt/KaGnoO6jmClPCM4WP5p6qJsdY19NJP3HbewAlmN/AAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGP4S4MMTMMlCwTZ9t/wNSHKNA1jra7gqEIR2qD5Ekk=;
 b=BOzhTd6TpAcqSYWyFmJcDQIh+VaOysv9u9wKh76VdNCyI2nmn95dJYo/hVLtzcZ/DIFbi7W1CnTCJfbev64lPXzqcWXn5x5OfqT//Z/kdZ1WYLP4PuY0AgLd4UKYUcJIzdOFGejQ8E7n57UVtMfPbFDu9wA3jE4YiTjsRd8k1576mUaydSc548ZdTjJr+WUujBHDon8U5fTXq3jtotuIgWfxTsOTlgXa8rtBVLGdVI43NJ4K2c6ImvjAQdh4+G1J2Fl1lICRppfqOnvSd57jI7MPnYovXAvV5N64ELIWAKcutQ37b+krJfJfAlAqzKAJ881kEPyMsub0Z4qKwHqsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGP4S4MMTMMlCwTZ9t/wNSHKNA1jra7gqEIR2qD5Ekk=;
 b=scHcHAQI2Ck8YMV86pZOOcpWqRwuvQR6gJGhgphMNQeZklmi2zDVQrDETUznw5cOEHVxAnu0hECZ6P3nTXmWZ0ReMr2rJl4LKPR7zLP0snNA4U2BZ45WwrpHHx2STSQAzdWeZSnPJkT/KYq6ArwIyLxsYYOoFLw3/R9epnHB67U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5201.namprd10.prod.outlook.com (2603:10b6:208:332::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 05:57:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 05:57:19 +0000
Message-ID: <755c30fa-a601-4ba6-8263-601439f1bceb@oracle.com>
Date: Thu, 11 Jan 2024 13:57:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't unconditionally call folio_start_writeback
 in subpage
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d35c15-da3f-451a-0c70-08dc126a2c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PQ0XmUpw7YtdQON1s/l1n2Ln+1Ans2PoYRW9IvpIRvXug57Cg/Cpg0YV0fW+v9Sv9NaLr5DUOmoHEoTsz1xntdcCJSYWg4cGBgC5RdXXK5h/vA00unvgftskAev6kws/+JfrUPqQBzWvX1cUphjTKGhLkIAX3T/IglFchMnOukeztw3iQMB40bEglXy2xnQuKMXklS67wPQfT1lhBYVGXp0XLsBS7FyyuFDVBAn8wDGsBwJcgLPaDoYqwaSkw4nTfw5OqI7b9iCGDXZaUvF0zUnYvZpl0l494zNUugadxDG0GgpM69AgW48y+ZAv31NNQmB2dPcSylwt0X0eTOGDu+7XOI2piOXAeq5fP0pwoo4WN1H/pEhq9Hgy4PaHmZ7ImL/FbXRUtSzlm8WvxSZaRL3+wY5icQWjSbYC/P9R4GPOfwE34t0UvpD+VALWR9rW1xM/WvIeAv7Rh9fTwfQZU0ey/LcY6aAxWZFnrLXnTcaJsjyfo5ZtvtIjfN4xEYdaKq/7QHPinurBDEQzsASvfwVRi2f5O4PSich9ZqUe+n5ApLGRRTkXeJ8ri032EguuaSRi+rFojcsN2ifPap46xW3TJWkUSX+LE953qE5SOuwM1solbqlH5Wn4gkX8txLkyTQTD21JXE+MRyqiyy+cSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(36756003)(53546011)(6506007)(66556008)(6512007)(66946007)(31696002)(86362001)(478600001)(6486002)(66476007)(38100700002)(2616005)(83380400001)(26005)(6666004)(5660300002)(2906002)(316002)(44832011)(41300700001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmQ4OW9TeFhwTU12c0FzT2l1bFVBL3R2VGV2K2JMYVEvUjlzSUthSWZXb2ZR?=
 =?utf-8?B?aFhPV253Vk0va2lxdFRBR3JkM1cxejVrc3pmTWNmN2FjZHkrUFhVN1d3RldB?=
 =?utf-8?B?QjBrUlpackkzWGJpYkhUbUJPTmJTWnUzdjRzSUdvOGNHb1FmMHNIOTI0aEhZ?=
 =?utf-8?B?bXJlRWY0Z2J1NVY3cTVxS25jd1YyOTJDcEJoekZGTlM5L3FpS25nZmRBZlVq?=
 =?utf-8?B?K3p6RHNpa3RObzJjTG1ERkdPenpISk1RYzhjeHVYQXFacnZ1cGcraVp1M29W?=
 =?utf-8?B?MlZ1Y1dEWHVraGhpUlh2RHVKK0x3Wlg5Skw3SjZCU0JPSnlNUGR5eit1ZWx4?=
 =?utf-8?B?MFRiREp3bXVtekNrcG5BeHBCRFZMcDVEaG9SMmVyRnZ4dUxJQjVqc2ZOc3hh?=
 =?utf-8?B?L0l2SU9mcEZtZ3EzR0dVQ3Q1RDJ3KzRoSnV4V2I1cmhZdUdEdmw2Y3ZJVnQv?=
 =?utf-8?B?K3dLS3REMnM5ZWUvWjNPQmZNSnc3V2ZaVERzSWVoa0wxMGpoL0VRVElFaEJz?=
 =?utf-8?B?cnJJV0U1WUx0V1dmUVVrQWE4UmVJZzZHMC92VzR4OEllbi9DRmhyQTV6c0Ry?=
 =?utf-8?B?RGRJeHBkZmpMS3lKQkRzamFTcEl1ZGlTbWV2ZFFWZFZ3L2ZOTE1ib3RhSHBP?=
 =?utf-8?B?ZWRqSjZXMmlTb01DRjRmNW5UTWZuTjdkbFA0WUxObCtiT2hNSkVzT0I0cHR5?=
 =?utf-8?B?cjRTTnBldE85aGo0Y0RmSkNXR2UxckhyRmJsL1FHWkxhb0FZb28wMDZFZlBj?=
 =?utf-8?B?WUJqK24rVHdpNmUzMDROQTRUNGRYYUliN1V1RE1XaGs1WlhyT3BwaTFUcEl2?=
 =?utf-8?B?bUpnTVplamx1SVZpSG96YTQ5TGRNbWdJamdsaWxRUmkzd2ZJOHFySUZGSWpm?=
 =?utf-8?B?dnplYlZyTC90eXpwQm5uY1MzWjBYblBRS3NuQjJ4VXk1OFBrbTVYaXlTTlly?=
 =?utf-8?B?RjhiTjNrVjArNzc0V2x2ODZ0bWxTQU0zNnZaeWV2d3dJb1ZxdjlJTlJ5aUp4?=
 =?utf-8?B?QzBQSUVQdVVJU0RDVDU5ZEg3cnZzcUorQ0pVVks4OUJRbEQ2MG1pRTZoM002?=
 =?utf-8?B?d2dSdVJHTFJkRDlSTysvSGNUdlplMFQvRU9yQWs4TFU1UTBoRHpTUVFaYXVj?=
 =?utf-8?B?MElnclR3UExnM2RHdnB5QTVEY0RIUXpCLzJUbno2Y1F1eURxZ3FWYnIzbjBB?=
 =?utf-8?B?dVZZdHlVNktnVlJ5Um1rT3daME1PT3BabEdqdTYzMDdWbmtTenlvNG9sSW5y?=
 =?utf-8?B?S25oQUFOb1Vza2tNYXJwNzNueWQ1UTd1cHlqeHJPUTd4R1lZSmozSW1YN1Bq?=
 =?utf-8?B?aGdVaVJOaS9KeG51MXFxVkYra3NzUzYra0N6aUJRNDUvV3RjQ2F3QUxzenZD?=
 =?utf-8?B?eStsKzZYUHR6cmVyay9SdGNtby9ESmovd3RuUjZvMGxYQzBDbklTWUppY0Zt?=
 =?utf-8?B?U0ZBc1RvMmxiQjA1bmRJZEtPYVgwazFaVW0wdjhPdDBSd0pWc2VCOE9aWW1M?=
 =?utf-8?B?a0xablZSOE91MWxzY2w1U2VSNkdMQXg2K1ZBMkg0SkpwK2srdlNETEN4MmR6?=
 =?utf-8?B?TDNLMWs0cjBFZmNpeHRzcXlmSzlIYWR3eHZ1dVkrVU11QnZpbk1JOC9BYkxx?=
 =?utf-8?B?bGYvQVE2WTlDVnp5UW8zZHRaeUFwRFNjQWRObGFHZmNzQW1pYy8ySTBmbWY3?=
 =?utf-8?B?bjZCTGdzQkVhZ21mT3VXRGtLeGNWVDdVdWdFQnFHdVR5dUxzSVBjMzB0WHE0?=
 =?utf-8?B?elBGTlFUVmVyeXVvZk5ZeHQ0WkY4aGFmRmszbEQxZjNQdUNvcHBNajh1NFYv?=
 =?utf-8?B?ajF4NHI5SEk4TzQrQThUbG9QQXo2YjlBQ0pOUmsweXhRcklUYlZqbC9Wd21m?=
 =?utf-8?B?bmI3cVVGZG9GbW16SDNXMG5QTUZIVS90ZDdIT1BPT2JoRzhQbVhnUm5ybUpQ?=
 =?utf-8?B?UVZ4UTZLVUQ5bTdNUzJPZ0dMSGo2eWlDdWZhK1JqODg5NHkwdjJBZkZURlV0?=
 =?utf-8?B?QkVMUkV0TllxanZ1TEFXRVgvV2lRMC9WWVEwdGt6U2YrVmhMdzJCSEg5cU05?=
 =?utf-8?B?RUVNdHZXQ01QUVpKbUh1cVlDZWpoOVBvN2RWN1M5ZnhpUzRERnFuTGtOWmtO?=
 =?utf-8?Q?uBGVksjTP9nrQt8IsQuaqty8j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TxFZT6kuHyszNAgR4EynDOFbg6T4mnftgfnGGLzJastAuMGuvMOZFGR9DwG0doDsyf/Y4yTKsWHxk5J32e6iVQ6RfHUWV5l/8trHZNZ7IWJUWIzChbUlCcc69g1NRHbKoGycTT33wWHw5fkhd1WsyBF9axTgevSlZnkMfmtp6BgRIzHi023kut0eXI0CkvEoQB1xt/ZvpGoAB+9BoPMt57CTQUZD3Ls/A5NVAqCiePo+rwWwIt75FTTtzk6/+10QCFN2zIPlOAYfjl3wOGRQGPhzieVIaRVbCoex3x8HPiSlON1CIpeKUBLq4AIS6z6xgX7kfpkrH+z9/NgeVUljtTeO4MlH15yEphcIP90j0l5g4Kqnzyowo3UV6P8EwiBFaJ5dCKnH4+iQktknoP8dGAT6QNj4Ui+cD3Pw4iaRszJs4oESvrLA5htHh8LI7iRNZwESVDr8bQKMAuBtfj1N458Je+WAPr8ahBHsUY7VRVC+es3dSYZ7kPBvEWRvPje6LxP8EtHaxIEZ5FIJTqU2i2d+jHeb++GS6ucv2Co4nTfMV2S3myoB6TxB4EgKGrfi7LMlMlwpobNSAlT4YbxMc9s8c8+8vjQNSPcA0zMhAyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d35c15-da3f-451a-0c70-08dc126a2c16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 05:57:19.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEuBtln9zvPeh89j+RiC4EUaWmYoxg78lZZVJX4N1FenzaWLwpT99dcGuFYqZ0UTmgR9uICmzlhDmQmK2p1jKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_02,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110045
X-Proofpoint-GUID: QItTHOJG675sbkWmIcGjquGFmkGthRMX
X-Proofpoint-ORIG-GUID: QItTHOJG675sbkWmIcGjquGFmkGthRMX

On 1/11/24 06:14, Josef Bacik wrote:
> In the normal case we check if a page is under writeback and skip it
> before we attempt to begin writeback.
> 
> The exception is subpage metadata writes, where we know we don't have an
> eb under writeback and we're doing it one eb at a time.  Since
> b5612c368648 ("mm: return void from folio_start_writeback() and related
> functions") we now will BUG_ON() if we call folio_start_writeback()
> on a folio that's already under writeback.  Previously
> folio_start_writeback() would bail if writeback was already started.
> 

> Fix this in the subpage code by checking if we have writeback set and
> skipping it if we do.  This fixes the panic we were seeing on subpage.

The panic stack trace in the git commit log will add more clarity.

Can we fold this into the commit 55151ea9ec1b ("btrfs: migrate subpage 
code to folio interfaces")

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

If not:
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/subpage.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 93511d54abf8..0e49dab8dad2 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -475,7 +475,8 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>   
>   	spin_lock_irqsave(&subpage->lock, flags);
>   	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> -	folio_start_writeback(folio);
> +	if (!folio_test_writeback(folio))
> +		folio_start_writeback(folio);
>   	spin_unlock_irqrestore(&subpage->lock, flags);
>   }
>   


