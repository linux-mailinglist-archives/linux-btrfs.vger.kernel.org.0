Return-Path: <linux-btrfs+bounces-430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DF7FD256
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7940282DCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0514014;
	Wed, 29 Nov 2023 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7GmRShU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxcNXnKF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99AF4
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 01:22:00 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT84igE015000;
	Wed, 29 Nov 2023 09:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=W/ah0N2hRpWBc7LR4bOjbYHbP1/SMKoXF4L3BVkNXgU=;
 b=J7GmRShUagGHZ3YTx5cfjDxc+/UQiQPnTlG0EzOtlLNJAxMkCuCe4o11eQw/G2BkBPro
 2MzbRAmcWPp+y15bpb9xDBHEjOkNsZ5Gjx2anepfobNv/Lp3J5d+0gX5snKYHDsPX7jm
 I5iPsUitp24dKDri7tF+SVWVXZ5bzC4gwF+7SJrV/xs36ROyii6Pm2HQmP9zoNlW5RTY
 lVrplxA2wP11VSDQjA3WXgNdOoNkHF/VFho2TOOEL20KQVZP9OASWXGsS22Gi/uwmSl8
 uUayNvlJwiQgnGrM5hkn0+QFrDZ6tGOXckF1Wj6N6wk9MFkeByqbW+p7N9sAK6zgWGO4 bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un5txuq5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 09:21:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT8cmsO012657;
	Wed, 29 Nov 2023 09:21:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c8ht83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 09:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV2RJGhZEUe52ftz07zBcHeidOA18JQXCG7Jh7zNVZNux3KmPu7Pos+SVli9SZnazxI1FAf5UUG2l+OftxZfuJ1PpB+IBIGBUUmA8nluYxZLcYhZV6jNv8buY8eIKpPiKThWOg9e/GFbjCPPcEnpWt+YMcjpp2w8sVtXHagawG98Z5E7juGOJnejFNP4fXcM6R4G/fbjXYFGw1OMzvE/3tuwLK3IWnUIYrysl2Jz7SUn8HAnnLxyW9U3Tw04zfh2/Rifu2JIwLPsi1fTHyjbRo9sbuOJAf7W1ZmXshi++QPJHqL1W9Qf3Tep3VRTx1cLfR5CvtDBsuZtiE28OMhKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/ah0N2hRpWBc7LR4bOjbYHbP1/SMKoXF4L3BVkNXgU=;
 b=gxuea0IIyTHV+0cl5ttsuLiiK9NNqKf86qNNLwdW5mFNwVhSrQeP2m7Rybh+1DP8JSe7iJpyNPFotEeLWaygdgpKGTpQ5AutpfXReo7kxh03q62ZqgNY0TsF5MKugg0n9hM3OJoGvAruy6Xr2V2v6vV59bnonrw3Bso8sJx/6dDxh7sg23F0ZjV40o0cohh/NbVt7wTq0nWlY4o13y30+0qmwNbXh9MWoHAUPbtZZIY3pj0e94mHysLBSbEoS11WZYL9HI5J+rZVKkuDHFYxKbq+T8T5j+XAaE4/QDr4CT2KJ1ahvBdIPBCQAn0ipNI7tVgUK+6+qOhTbWXKY0x7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/ah0N2hRpWBc7LR4bOjbYHbP1/SMKoXF4L3BVkNXgU=;
 b=oxcNXnKF04xCDYpXqYSzJD69cC4kaCU5KhkxQJGCvZIZ1BNQRNgvPw75+akYJQoiyLDdu/kfdOn1t02VADnVYSv2onbtP5ECTP9i/KiA89vxf/dwtBuBWqZVD1XR1F1TP9DHiYd4FiQ73QpgoNeGW19WLN8E4q3Xs6kHXbumvU8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 09:21:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 09:21:48 +0000
Message-ID: <35b15f56-c687-d68e-a0f3-aba8445c8ed7@oracle.com>
Date: Wed, 29 Nov 2023 17:21:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: allocate btrfs_inode::file_extent_tree only
 without NO_HOLES
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231128212307.1838-1-dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231128212307.1838-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 72875de6-092e-4b2c-9b62-08dbf0bc9d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a69ihBLGiELlTHG1vQ6qdZ7T5dHd7GNEgAFE1Hwlntokbi2I2jRnr1+AlDl4yKXU3nldyQ/6aJY8kd6iZFA3dEx1RHJQWL9tYFE5R4Jv03y1Wj/xVbI1b0D7xvwP7WYQlOoomXl9g3/dB6xRP1ikTjbrqabRlWOnk9sRxvFvhBtDbZP+uoJZR4jzAYb3YtJanYJguE6oeWrCMtV5m4Fqv87JJBQQem6fnxVoDsywECLy2+fchyP5jBIGD3goTiyAwm0A+kKkUqaO4S/2jGbIhysaZ4PVG4qwV5BzorTmq2Id3YKDw4pDU9GLoqb+Zd6Y9TJ2YCkNeK0fgjZs6ZkmreVzW163KDyFFnRDVCik4jtmCq1gk0uK+irxwgXBIsj6yKbYZpG1K+OkeA9syIQaYp1aTXcvC9N/CE70pRq38tslo/NvQh6Rs/JM4Je3Ia5BWXcSN4uLMZgdjdsnoqMiHk+VceJD5mKdpzrRUA0F1TYJLHZ2GUQCCT/4HSGN6i4NsjJy4Mn8rDc9JUF2Ef1mOLhcYQcB5vVGB99CKzDA4ue38sbhy/9HyBT3g23CiwX0ZA4He19tBr/hdP46Je2NRuRLP5wMiU4lDoovFrAmzdPRUyNFk44Zy608teJX3JUAq5dHk17kw6BUaD5JKyXTqQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(31686004)(83380400001)(2906002)(44832011)(86362001)(31696002)(5660300002)(8936002)(8676002)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(41300700001)(6506007)(36756003)(53546011)(6512007)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGNXMzVpWlpydUg2dXZoQlNGajFCTzNjOWNWYnZZWWN2N1YzTFlDYk9yREcv?=
 =?utf-8?B?VGR1b2syaHd1aDl1Nm5kS2NnTEoxZGQrdFBkR3A0Vm82TmduUG5sdUVxVGt5?=
 =?utf-8?B?UW9YMmpDNkJpeml4YWQrRGU3MjlUZ21ieGFWMU9nOSswOHJlSm9OZVRJa0I1?=
 =?utf-8?B?TURib1JZWitPRjBncGpMRC92dUhHenFWdFZmL08zd0ZRWmwzVkZyOVl5dUhK?=
 =?utf-8?B?bUVBQ1UwNDdRSTFYZE1qSGVuc213cHoxemVzZGlEUHRpdDBzbTcyeVYwcDc2?=
 =?utf-8?B?dW51aU1GcENtTlB2Vm1xOWswR3JhcVMxQ052OWlHTlIzTFBNbzI2bEFyc1lm?=
 =?utf-8?B?RWRnakkxczEyTklLa3NSS09JZDBtMXpKOU8yVVhDZHlMMHdUZC9kbXAxbnp5?=
 =?utf-8?B?S2tuTFhmbXlhd0lsN3pQaXlNa1lTRVNQOGRqeVdRTmVCOU1OMG44WjhyWm8z?=
 =?utf-8?B?bXhDNUl3Y1plMityemJ2b1JrMnhRVzE5dExXQmdOdzJLSDdxd3k2cHJWbVJ1?=
 =?utf-8?B?a0p3MkVZQU90ZkovbmdaV2EwV2I3Mko4azZJWWJJbG9WUFg1Z3ZpYy9tQUZl?=
 =?utf-8?B?NzNRQTBZdis2WGdQNU5iTTJUWWVmczQ0eDcvRGMvYW1HajhNdzVxenRJNjlD?=
 =?utf-8?B?ZWp6NzNpMFpCZEppSGRDemRqMUVjeGN4M0lpZTU2L1Y5N2lmVG01RmdlQVdp?=
 =?utf-8?B?cG9NWTlmb3BlYUs2L0RZU0lLQjNsdjQyZ3dTQjNVSmRBMkJRNGM4TGNGMElq?=
 =?utf-8?B?Y29wNXp6SlhXUisrRjc5RHQ0UWlTdnhGVzVFbXJNanF0Vjg0S0tvcDNSWCs5?=
 =?utf-8?B?ME1Hb0hEbTdyWEdKY0hZc2hJZ2RqZTNaTUhpQ2k2VzRUN0s4NTJLcVNxSWd3?=
 =?utf-8?B?S2Rlc1laV25nTmk3a21Gam9ZNXlRblozZjFkT1p0Z21kclYybXBJVmFmOE5C?=
 =?utf-8?B?ejVPNjRGT2JZdE1pWTJsZ0Iyc3UxSm8vTjEzd2NRS2lXRnlSRW43Y3krQXFG?=
 =?utf-8?B?QUxQMkY4OFRoSkE3c1BPaHY5aldXSkcyUUlMUCtpMVdneEYrMTlsOUkvUE1N?=
 =?utf-8?B?YUhrcEdUVlNIMlgxK3h6R3R5YVRSK3JMSmZrRGpSU2tVOGdpMFE5K2pHQ1JO?=
 =?utf-8?B?MlFZVURMRjZ0RE5XZWF3b0lkNlF5Ykw0Wnc0dkFhL3ZHL0xFSGw2VlVYNnI5?=
 =?utf-8?B?UTM5LzVMOFE5WGx1eGJBcE9yNHZlbm5ZdW1iMWxibHRkTU5YYXk5cS9MMEpx?=
 =?utf-8?B?VzBLdTlkLzdUMDk2eTRTMGNicnR2R0lGUkZtTk0wdmNuZ0NHeWVUTkc1YW9a?=
 =?utf-8?B?eXFlRWdEbjBUOHBRM2M5NGRnNTErR1B3QTFhU3BKamw5aXNpSFQvcVRhNUtC?=
 =?utf-8?B?YnU2MXFRRG9zTFFRMUpIRjlZbzc5WFc3cVVacjZlUE5xeUI5ZENvTHF4WnpG?=
 =?utf-8?B?bGVtcDJhQzR0Sk1qc3lUWFA5R1ZUajhSVjhuZVZVOEJ6TGVpQmJPNWlvZXpq?=
 =?utf-8?B?RU0yMnlyazltODZFM3o5MVlNZkJ1TnpTZ1gxMk51Q0hjT3JnNzF3aU1XOStx?=
 =?utf-8?B?SHNVaTByWHhwTTBka2JZS1prQXcycjNWOERUUWpPOEo2UUxCMFZNUWxEbGVs?=
 =?utf-8?B?eG83cjZOVDBGWndFMm41UlVOcXVDNDlKK1JaTHVwbmFEREt4ZEE1aktndlFP?=
 =?utf-8?B?WDk0Yk1KZU92NEVaTWdJeUozaW5KS24wQ21RNVZ5djBhdy9mZ0pHN21uS3By?=
 =?utf-8?B?bUc1N01GbnU3VFlXSW5aQzN5cTcxMG94RWpmUVNGY0VmV05UcmdRM3p4eWUy?=
 =?utf-8?B?V0kyRGxBVFdXYXd4TzJ5TVE3ajlBQTg0WE5mU1loTllKdW85ck5TTGRvdnYy?=
 =?utf-8?B?WjhvVFc5b1RROWJBNFBmOVk5dWZqdWp5S0ZrUFNheWhXUzNnbnU3UkIycmlu?=
 =?utf-8?B?TUtvWUJMa1N5eGkxWWJjc0VQQ3FnTjhJZWZ1YnFyMHNUblpVc3RUL0ZyVmlK?=
 =?utf-8?B?UGNUTG9FVnA3ZGYrZWNqYmNzenNsSmxOS0lGcFBoaFliY3ZVQjYxUFJkOWlV?=
 =?utf-8?B?ZVhGS0RCaUs5Qm1HSkU4QlRZOVNiUGNHOWlSbE5hWGw1eDJrWXp4M2dGQ0xQ?=
 =?utf-8?Q?OG5u5fIKB/9nyYVmCsZx7x7eW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ur1mEH25d/S5dugLwEiqV6LZDAFFmr9fyjnRijz5HK8gbdR0v5hKV2+vqrf/vzntXNXFMDK9IzymOlB/1WmVKBrqTlUwPmTyE+vKrAix8aSrmPq6ZQvywXSk9T1edjs8qBzOZaHYD3ITrifeDIzh3mJlzQ/VkcQ+Tek8JiKEnlfrlvOP6Ll5fo40hKKr0QMF/aHCmo+t5ygdJP7pauzk5cjhGZTYUGtshmZBE15tGiC4PJ8DRTjdDHl+4BQHi3WwySs18TyQOEvI+BNyy5l0TQaO7K3VJqaBiqcxdY5DbNnFiHNNlSew51IAdvvo7lOR9FSms3FzaxHzR60ml96JyEgt+TTGkTujlVU3z9vFeu88aGDeOFvz6ORrTiVuc2y+PZnf21IdwAJDxiNNeJvsFvXS6dP+C3KOlkPr5SugDF/WNAe8FjE2/mE5HqU0c8T9Y2vNksud0U+VxcVUeYwBXcYwpKksUQpZyLHbK3bf8wy9Jvlzj1xqYgGiBmR+mW7i5nGpWXuqpPdF4iry0DpS9WH1FiRMJmWPc7sfhtsB20vYWTlolyvRaxYw4hwzR3/565VzQ2UP6CTTBgSVxLNKQ/QwrTxAoy53f69Jss0Km7rgwmz0peblFWQOwzrVZeF1QSwl4oFfarMW2sykA2ume/+DnAqIuI6PiVCqhyxS9PyovT/cIbhZkEaFHBwX687VcgaWZeHGHgzrwky4RYShVkJpDW0JDs8NRh0zSSAtDiomNl8WFUKzVHzbSBBEimGFzFHWZryRKRPPFNwVZ3LgpTOXmqAjZaHOUgz7dTmLp30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72875de6-092e-4b2c-9b62-08dbf0bc9d1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:21:48.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUXCLm117Aflxw0Odcg7jIWqUqEHqXXSwWemYtKT/LicJ9JVwsS8xNjFCpId3xoozDp0Y9rulJvNmU2E0iDsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290068
X-Proofpoint-GUID: _TRL6lOY7YVFCXX8ageg3MlS5AyS0M-n
X-Proofpoint-ORIG-GUID: _TRL6lOY7YVFCXX8ageg3MlS5AyS0M-n

On 29/11/2023 05:23, David Sterba wrote:
> The file_extent_tree was added in 41a2ee75aab0 ("btrfs: introduce
> per-inode file extent tree") so we have an explicit mapping of the file
> extents to know where it is safe to update i_size. When the feature
> NO_HOLES is enabled, and it's been a mkfs default since 5.15, the tree
> is not necessary.
> 
> To save some space in the inode, allocate the tree only when necessary.

   I don't see how the free is taken care? Does it memleak?

Thanks, Anand

> This reduces size by 16 bytes from 1096 to 1080 on a x86_64 release
> config.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/btrfs_inode.h    |  6 ++++--
>   fs/btrfs/extent-io-tree.c |  2 ++
>   fs/btrfs/file-item.c      |  6 +++---
>   fs/btrfs/inode.c          | 23 ++++++++++++++++++-----
>   4 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 5572ae52444e..bfbd0d896fcf 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -107,9 +107,11 @@ struct btrfs_inode {
>   
>   	/*
>   	 * Keep track of where the inode has extent items mapped in order to
> -	 * make sure the i_size adjustments are accurate
> +	 * make sure the i_size adjustments are accurate. Not required when the
> +	 * filesystem is NO_HOLES, the status can't be set while mounted as
> +	 * it's a mkfs-time feature.
>   	 */
> -	struct extent_io_tree file_extent_tree;
> +	struct extent_io_tree *file_extent_tree;
>   
>   	/* held while logging the inode in tree-log.c */
>   	struct mutex log_mutex;
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index dbd201a99693..e3ee5449cc4a 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -962,6 +962,8 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
>   	struct extent_state *state;
>   	int ret = 1;
>   
> +	ASSERT(!btrfs_fs_incompat(extent_io_tree_to_fs_info(tree), NO_HOLES));
> +
>   	spin_lock(&tree->lock);
>   	state = find_first_extent_bit_state(tree, start, bits);
>   	if (state) {
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 45cae356e89b..1f0110f48353 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -59,7 +59,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
>   		goto out_unlock;
>   	}
>   
> -	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
> +	ret = find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
>   					 &end, EXTENT_DIRTY);
>   	if (!ret && start == 0)
>   		i_size = min(i_size, end + 1);
> @@ -94,7 +94,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
>   
>   	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
>   		return 0;
> -	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1,
> +	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
>   			      EXTENT_DIRTY, NULL);
>   }
>   
> @@ -123,7 +123,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
>   
>   	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
>   		return 0;
> -	return clear_extent_bit(&inode->file_extent_tree, start,
> +	return clear_extent_bit(inode->file_extent_tree, start,
>   				start + len - 1, EXTENT_DIRTY, NULL);
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 096b3004a19f..04bbcb6bf34b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8472,10 +8472,20 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>   	struct btrfs_inode *ei;
>   	struct inode *inode;
> +	struct extent_io_tree *file_extent_tree = NULL;
> +
> +	/* Self tests may pass a NULL fs_info. */
> +	if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
> +		file_extent_tree = kmalloc(sizeof(struct extent_io_tree), GFP_KERNEL);
> +		if (!file_extent_tree)
> +			return NULL;
> +	}
>   
>   	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
> -	if (!ei)
> +	if (!ei) {
> +		kfree(file_extent_tree);
>   		return NULL;
> +	}
>   
>   	ei->root = NULL;
>   	ei->generation = 0;
> @@ -8516,10 +8526,13 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
>   	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
>   	ei->io_tree.inode = ei;
>   
> -	extent_io_tree_init(fs_info, &ei->file_extent_tree,
> -			    IO_TREE_INODE_FILE_EXTENT);
> -	/* Lockdep class is set only for the file extent tree. */
> -	lockdep_set_class(&ei->file_extent_tree.lock, &file_extent_tree_class);
> +	ei->file_extent_tree = file_extent_tree;
> +	if (file_extent_tree) {
> +		extent_io_tree_init(fs_info, ei->file_extent_tree,
> +				    IO_TREE_INODE_FILE_EXTENT);
> +		/* Lockdep class is set only for the file extent tree. */
> +		lockdep_set_class(&ei->file_extent_tree->lock, &file_extent_tree_class);
> +	}
>   	mutex_init(&ei->log_mutex);
>   	spin_lock_init(&ei->ordered_tree_lock);
>   	ei->ordered_tree = RB_ROOT;


