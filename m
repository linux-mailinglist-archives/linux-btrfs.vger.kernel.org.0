Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85898338D5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 13:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhCLMou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 07:44:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCLMoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 07:44:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CCPNZt128707;
        Fri, 12 Mar 2021 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Cb2j+N5AlLLtIJxCt+kqWNd6Tc2NfZLgx9A0d1o4E3c=;
 b=bTizGWPPCZnA1ITNYmy6AjMrcy++un7Lk770HzGs07VL4m5iSJ5eQoEfrje88j+qsWPw
 deKHz3ELwYtRXlltW+SEoaNDKBKdwPb0KrpbNknavND6zvar1gsRvqqOmyzrj95lTxqf
 FrxDMQlwqvN8wCjtRHkGM6n4CeSWXS9vh1NmbwUFwFLS0aweQSOpLer9MVAaErwPaaTb
 yP6yOT9MM5KPwa2hckHuAzkS4NFizKiJjD4FR1UM6BhiUMKGEwObVRJPh6BgQNzrPkFk
 Fym28MnCAO8/8G/mvF08hvpPqOY6y8JDV8la8mKbWf+O/DU/EC8lScxBk6tJaC8BuE3B Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnhvqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 12:44:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CCPec8177519;
        Fri, 12 Mar 2021 12:44:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 374kn40scc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 12:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzAtMsIDRH/2FZlFRiqVIx2fy4GiXVd1JkN0AF3f+BUshcZpqb47oAIaiwFkDok6XYCWtMCtbYCr9yDmgfMVCbj5I2SpsWtqXHBPCZ2Rm3NvxZnUkKGG7MGWW8wDbg5q/z65sH6RwRyROKnegETiVAEF9DGMzozgr8wpvo7W+YZWm6BC3L2ybl2Zt6NR/UtQm+KsAk20jUUTobi2HZnna+L2+j0PHEDSz5xkvepmPydZGd66AFyq723ZcJGdWJVLDkEKYsnjGEfszsnaV9unsfhalsFfb5amZ3SReImEOTbTKaUgrZSl9P6en9DNXSMJpBe6ozkx/pSaZOu3J8f2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb2j+N5AlLLtIJxCt+kqWNd6Tc2NfZLgx9A0d1o4E3c=;
 b=IANcdcer8Jw2gkV82N5R/DNYfWH+CJ1WBPwFDnoXchxH5/9CrG3HEcJ6IV5ubwaR6RoBHxgwA8Kt2qYblJoXFFiUsXvJLgoPcSTvw6rDFKL860KCD4aEoP5bqyU5Lx0V+z/Jd8Hbq6JQoxdZpcuDpHa6G4i1WGQmzHUIy6sGx+lROwtdC/Dc6ImTGt0aAmrLkPr3E/B9Kt0cs+1MzuT86Xd7aNmwiF8R97D1Zu72C9JRLoILfvGKc5YEP6ERYpMAovdF/ei7WKskKi7TYX7APv5w/va8dP4ChVQxyILtYvJ0yUeheQB2tTjocinILdw99OTRQ6CwO5FTSo3l3axwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb2j+N5AlLLtIJxCt+kqWNd6Tc2NfZLgx9A0d1o4E3c=;
 b=yM8hHDIW8Q7XvaBscKQDrm3Swj47nB1N4YlPhYYWw0QD6gBlWPaSXr0rzJPuDwDvqepubli1t5Di35itYpmG64YPGYzTtlCEwvoe52YJDIqjTtZ4Ap72VzOorHzHNVkMKniMs3LzxarWLBSUC6Ax5/8YEW86D/+EC1m3jcWHIc0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 12:44:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 12:44:12 +0000
Subject: Re: [PATCH 4/9] btrfs: use booleans where appropriate for the tree
 mod log functions
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
 <ad94e2466afa62fbc64ff66af85cb6ec0d1235fb.1615472583.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c80c1bf0-f50a-a91d-c5fa-dcc4d11f6929@oracle.com>
Date:   Fri, 12 Mar 2021 20:44:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <ad94e2466afa62fbc64ff66af85cb6ec0d1235fb.1615472583.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0014.apcprd02.prod.outlook.com (2603:1096:3:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:44:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 043f86e7-306b-46fc-66ce-08d8e55488f8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4128:
X-Microsoft-Antispam-PRVS: <MN2PR10MB41284910885A72AA81C71ED4E56F9@MN2PR10MB4128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBxDNcKxNZNW5ZG0mNB7A75SLYeCbfSKbZw/PKJPygcZDXvytI4A/y38P2qVYIiZSDXX/QayLkPHFZc1/yW30M0Fpocp5yfN2XbhiZ+ahO3NUqZJl8CoPCaJ4ajoWUxSTK6txPolqVdyfmW3lPXKCYU9tb52U/+kWixH7apQOWv9jPhFDKYBp3CyjjUnEl+AW3C5xV4X4xjo9cOeR6zwrLdAqho6lTfQ7C5yHfjxHJd463+Wf0slEXCf2qD/QG86TEsprlrPXmfwkXp94trt7LgKiUZrwrg0BnZC4tixwiP/8ms0TZAG6nWxpgizBNNF1ImyjeWQ8EL2vBO9TrzLNwkRc8/K7TZ++1cYFmaIUJglGvMu9vQIiBtib5s3ltYEyLEMhzlpiEmoZWhl9xw6u9UODucESMt8w+92mCshFRha+chGy68fyWKWVt1m2DFQhmNbO8IqjkowG/k9vlP6RSNcTLGTx3C9N0ABpIkRva7pmElKl6BZlZWWBn2yv/OT2+6se4zy2JY2VNM06r0nUIDYGdSGr1mw9zt0mudBkGQL84RfoOxkgAIzFrTWc8w5oKa4uyzjbRBoWq6zmaH1Odq/KLGSbXIptw4evcg1O7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(6486002)(2906002)(86362001)(4326008)(4744005)(6666004)(31696002)(53546011)(26005)(186003)(16526019)(44832011)(66946007)(66556008)(66476007)(31686004)(16576012)(316002)(36756003)(8676002)(956004)(2616005)(478600001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bVUxYkxSZXhGYkVlalJ2RUZtL295NVVsemJzUWYzQnFGNXBRT2hTQ2lKV1l4?=
 =?utf-8?B?Q244ZVRDMUtPZG9UZWlWZEF3Q2dxUGNDQnB2YU5VVzZBQ0h0WFFtdnV4T0Jw?=
 =?utf-8?B?TDQ4cUxvYkxFZnFpMHNZOHJ3Q2dhSHNDVTM1TitIUUgxRmRrOHdZV25qcTk3?=
 =?utf-8?B?VDFXK3BkQTlxRFhmZ24vMDJnblZRNS8vUUppKzlpTU54VzZaL05aZ3FMQVl0?=
 =?utf-8?B?Vnd5VUdqYk5yNlZwdTY3MHFKdUlzRm43RE9lZUlFeTJ1WnVGek9JNkNDeE1K?=
 =?utf-8?B?bjNWYWR4T215dkRQVDN0V3lUMUc3bVdaZG56dW9XemcyQy9DU2E5aVhWL0l3?=
 =?utf-8?B?dVdGcnFTRzNYZk9pUDlETVFBMy9yb090V21DeGhYUFhKRzlOR0p1bDdSb09h?=
 =?utf-8?B?akErcVlOK0xlZ3JERFZvMlRHQ0huU0JvZG1sRWdHM2c2UWJaYncxWWV6dUZ5?=
 =?utf-8?B?RExtNzRXTzQ4L1hFOUN4Ujk4OE5nck03dUs4NVRWVXpoVWpZdE9DekprRm1H?=
 =?utf-8?B?UWwxZ05WVExTQjlsMUZhTEx1UVVYWWx4TzNYc05WcG5QQnAyMWl6U0lqRCtp?=
 =?utf-8?B?bjBoMDI1bFkvNjNGSGlMOXVNem1HWldXVjJYVXBKSUtWYU91dkFkdXlnS0N6?=
 =?utf-8?B?d3cxR1A4MlFROEJuMDN5dEFkNDVBaHF5bzUzSGdhUHBNRDFiUVJjTFdwaWpW?=
 =?utf-8?B?MHBYL3VDdjQzQXBTQW5KbE9ZSnpJd0M3RlluRVBQb0FhdlRsUmozWUZ6UWVh?=
 =?utf-8?B?cEU4YndnRFFOUldNWkJjaklPTGpSYTZVbW93UmU4bUJ3eEQ2NVZJcDNpWG16?=
 =?utf-8?B?WGtiSlprcTRiSUlDRU5UTHI5eHFhWTNCaUViUWJnNHZQRGE3Q3pCRUk1a05F?=
 =?utf-8?B?ODZMN0xJWm9zaTVmdytqY2VOaysvQm5NRmtMQi9lRUxyVUhaQVQ5ZzVKU3pK?=
 =?utf-8?B?cjh5dEE5WHZob1kvOXVySCtMeEUzQVR1VzVGRFcrODJnemJqeFNEMnlNRGVr?=
 =?utf-8?B?Nm1ETXA3MW4xOWJEVTAxN0RDbVVyUDRZc1JIaHF6bFdDMCtMbHJvc1ZkTTZN?=
 =?utf-8?B?NWxpbEVOWlRqY3lWWWRZaFpId0F0SDU3SWRISWRSTjM0cWJza3NqTFZyWVFE?=
 =?utf-8?B?ZmRjdGFjS2RaRVUzejk3MnRtQytOd0M5ZlNDK056R3RCcks4bFZ3dzVlWVhG?=
 =?utf-8?B?VTMzamVzSVRFM282QzFORk5BNnkvQmd0TmtQdWN5aDFHQ0gyUElZc1ZpWkND?=
 =?utf-8?B?VUpkS1FYZGpFNHJheml1bDZrVCsrdHVtbDBzNXpiOCtCVWxVNzJoWnlJTFE1?=
 =?utf-8?B?WW5HT2FiNEk1MkNWUXhVbmR6eDZKSjVmaVp4bnBsamYvUjFZdGdDYllpak1P?=
 =?utf-8?B?WVd2S2luUW95cE1HS2hteUk4Rlo0Nit4NzByMk5rRUxxSUc4aU5NM2J3bGth?=
 =?utf-8?B?d2tocXF6TW5FQnFQbjFKS2RwTldZYzBnNzlhL1RvaUwwZnlXdm95YUhjUDNy?=
 =?utf-8?B?di82aVBkcHlOdjdXaWpZTTNMVldnVHdEeGlabU93MWVyZkdDbDc0b2t1Q3o3?=
 =?utf-8?B?eHRWUEZMSXBib3MzVXdEa3lUWkJvbTJJTWxwd3NRVjYwWFV3alB6em9IVyto?=
 =?utf-8?B?TmRTZ1BjQUVGbm5lc2wyMTZQUm5MY29PUjNtYXVUd0hzanpUWFJXSEVJanYr?=
 =?utf-8?B?bjNzSStyYkh0eVk3T29aN2FjZUtmTzZySmhaN0x5RE5QdktPVVJsQ2RBQzE1?=
 =?utf-8?Q?Z0vIHASrg+fDxU/TLXF6gWsIPmXgZsI7u0+6Fon?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043f86e7-306b-46fc-66ce-08d8e55488f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:44:12.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwIBt9phQNFJ3fVnKn/cvhK9hxDlsC0mFZeD+2ILCaXTbL5u2WpUTSMvZuLVD/7Tkx6G2iNUxltgoIaqv4fQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120088
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120088
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/21 10:31 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several functions of the tree modification log use integers as booleans,
> so change them to use booleans instead, making their use more clear.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

