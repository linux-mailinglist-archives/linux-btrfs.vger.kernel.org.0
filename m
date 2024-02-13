Return-Path: <linux-btrfs+bounces-2342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5F852787
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 03:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE261F22C05
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 02:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C747499;
	Tue, 13 Feb 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VwIr+SD/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dLa0Kmgu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0726FB9;
	Tue, 13 Feb 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707791806; cv=fail; b=MrjyHJKQkuvAptYEKCIxyCCrGJLymp8bVtFiROQHJL0Y25fgMbaq4br3mljlaErC8tzIuS6PwUryuCkzsVkJKIWtyUxtvlX91hzSG41xljxfA/uCcbFZZnRApXPQhVOpoh7D84FTkb+u+mfrs+GthpuCFaEJhzXXUMb9L/bcPBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707791806; c=relaxed/simple;
	bh=doxZc7DpIQvbqcWpPL9vF7rQP6PYdaov782M4G7zj9A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9reKstPqnRfQuU0sc9uOtrfZ3UNQpInIKk4edGYfiR2CGC8EE++0TCe0MJhyDZpwKSzWveW4DZYsELg2KjpUtg76k4NLRToL9wYy7g9sJMCb5WO+yIDQ+cduHxfRHT+rM8be6DKeLa5gu0ft3mcoNSiVOcTzvNcKKZ+YsiqdnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VwIr+SD/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dLa0Kmgu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1i4et017111;
	Tue, 13 Feb 2024 02:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YLft4V1GnLYZhUzmmXP2gPH8/IzDyqLbKMwZFyiagGc=;
 b=VwIr+SD/0/Ql3LkiDWEYoFCJb8o4w49oO+sco/9s5UDLBtHucGrYUyHA76qS6nrXB3ke
 caJP1b+7W8fWJ01qtg6n9E1CVdusnS9xaLkCl95M9WzEONf5qMY8b8EszZUrWlXT1D5h
 QIvZrk357wgBesM3hE5PyTK+OYJ61klaOaXs7XAomYc821IVBksJk2FzjRHUriPDHsLY
 dkr/ngptQDS3xd3di0KSN4n97rpUX910wnMUzGxC0jaxL0exWlDk8o1PMRp5ZEfem305
 Nc3XBw36aunhRPe1j0dHNWyHXyoYECjZTWkAFvnk6NxdX8XDMFFzOcHNu00a2X+YQd3b ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xuf82m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 02:36:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1HobN000883;
	Tue, 13 Feb 2024 02:36:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6nxhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 02:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0Qq6wfHSOP+hQDlYioT3KmodVU1XjB/ROgXPaErZABk5B9FE+WKjReSF/gaAyeVw7Rf2zgkli/+DwjVkF3HxklIaVr1NcHVeY4KgvOcmrVmyckLE/MarediU182kQyV/GIvpoCFGz0er9H5oL5/mfWYoIpc9Rd6XSI8860auTFR4a2IZYW0y0FyeXvWqaAjgU7CxhMhNkre8sT+zBASMJdoh2/Df9Ie5G4kdA/2FJgK2k2tGnoYhisOEVK39BAihfz9/leJ9uWSv2TKpbGiKSlHLIjgKPb4MVp3BOjqZ3Dt2F35f1wGrfhgD3lZLAffw9z0HoCmiXl5lOY3Pr6j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLft4V1GnLYZhUzmmXP2gPH8/IzDyqLbKMwZFyiagGc=;
 b=Ycq2/kNrVXrO20LOS1G2oCmGbplFqWND+oU9DOfSvgMZ/zesnrFzliGS3WL11KdoXPj2QPB2gtmccLJsqg7sSMKXIv5J/K3KYzygrRu0r8dAsQrqSOzAYBZdcaN9xU39tDfyHsOf0S4gj2R0mMIfhw/BHN//i7gUPCtNRc/DSiPkoIbN33EF6Ops7FGiaGWlQd9uTx9kDZObW2nyhVjIcHeyY4IfeuUNeHjyKJu4OMzrj8VOAt/1g3foMcJiQZk1r5X3n/qRl++FLU0bLzJ/9+XYhHd5z2AARJUhxozLCSlzOWqdr4POU+iflL31/uKcVOeJQXwGBgblVPrNawJ1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLft4V1GnLYZhUzmmXP2gPH8/IzDyqLbKMwZFyiagGc=;
 b=dLa0Kmgu9S1xooFD+qAcRQqMyGMovg9jUS9OkicGiYFpLUcIhKHV3uQqWmb2kD0oFy12hrrNak5Zv3dQPKqbXhAuuuWL+JZsH9fI1qFsAPc/8uvG6TdC1xK7Ufu0y6/4e2EouKMg1sbjwNq+VjRnFAMuSzMX/zLs26HojAtvvnQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6853.namprd10.prod.outlook.com (2603:10b6:208:426::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Tue, 13 Feb
 2024 02:36:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Tue, 13 Feb 2024
 02:36:38 +0000
Message-ID: <11f457e0-029c-4fa8-82e4-78a56779fb88@oracle.com>
Date: Tue, 13 Feb 2024 08:06:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: add a regression test for fiemap into an mmap
 range
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb7e265-2572-4a83-1589-08dc2c3c9a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DaCnhf9Yujs9SD2wgTKxNBIwUJUTA7WajYzaaKb7Hy5oM973z2H+2//9OunD+voGtr6NQolGfAR0BPGdz1cSEdWkEBzZHlFEKNc7oNVAnK8oFp7oZmdWnipS5mO74OyTG5SU7sHqYE5SXo5rZo8vjzLSUBaniihdIT+ax+IQXSwD6bvdrZi7FeSgKzwVrT79GH1GqfhRe7/3evKR8pe7PFBgN2knW65bG66FE4W1PrMIse5WvvJj5AQxyafdXPM87E3J7m9uHiVEQ9yqMqht9TOToqD8c2H1wpsEDgpYUcJ5U6CAPMSLJCNURsW+8dNYzl/f9QYGeUHv4jijo3XGO9IDdwX87yMGt35s+5VayYQPAMVJ3g9FtMrLlrS5b63fWbiCNye32JwEoY1rRyl9WwWpSOoTFVSXNFLpaJKCSuIwGTaJACJ1KRnsVvLDw+YTWC+2rxOHfdLpuxnA4S9dzhPo7RwubAFve32WsPvjzHDw/HCjL2kgzng/D/G84V1Zd6rIbDqkLy5J4ImkJA9i/sSNp3NW6u47KsZyiq8bruiyWQ+XAmlIVK0n2Sk1D/v1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(38100700002)(44832011)(31696002)(5660300002)(86362001)(2616005)(53546011)(6512007)(6506007)(83380400001)(316002)(66556008)(66946007)(36756003)(6486002)(66476007)(8936002)(478600001)(8676002)(6666004)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXBUMGJJenZSWVdqVkw4V1JyZFdKNzJuUDZwYWRmZkgzaEhFaTVtOVZ2Vkpz?=
 =?utf-8?B?QUh2QnA1S1NXS0Y4OHVXNzBLZzVMRGdXOWpJQTZ6VkxsOXVRZ2ZQaklvK3dS?=
 =?utf-8?B?TnhnYUgrN0IrM0dzTzV4cjVUMXQvQ1dqeG9LT2RjdDZIYnFHbXJLNkE4N1I0?=
 =?utf-8?B?V0dYb21TaEw1U1kwYWpHb3pVTEdjb0VKZ0VNOVpXbURJcU9VV1QzM3V2T3c2?=
 =?utf-8?B?cG5kaEZnNHkyK2hCcXJxNjhsUDJzclArY3RGUG1oWTZUU2h5T0Z0YzJWc2VK?=
 =?utf-8?B?ZkR2Rit4VWJjZmVqSFlkbmFDdVRaUUtSQWE1bCsvemN4OENwc1lXaGxVbzNG?=
 =?utf-8?B?akE3aHVWeTdPRm83MG5ReVI3eHhBWCt3WmlTSTVScUFGWG1nOEdUekRad0Yy?=
 =?utf-8?B?SVA1eGlsUExZdTQyeXVkcEFSU0U2djZMRFd1WTZNUzVTcStLaElvNGRHQi9h?=
 =?utf-8?B?UVBjcXVKSTgyNE03MitvM21TZk5uUlViU3FMdTdjaXcrYjg3S2dJNndYUEd2?=
 =?utf-8?B?WFRNSW94SWR3UXZsTmhRcnMycTlnQXpxYUhUMG9CczJZeWpDOWs5MGNpeTE4?=
 =?utf-8?B?dmZCSmxiY1VacEMrZklIZ3dpVDlXZ0lPbWRlQXdTZHcxckZGUVhPQVFUU2sy?=
 =?utf-8?B?TTFTYUpEcXNmOElmTlhEeGJqeHg0bDM1NFR4LzNVUGVtSE5Jb0FMUCtNcksx?=
 =?utf-8?B?UnJIUEo3UWwrMGRGTzBOVnhIWlNxcnJWQ2kwRmZTTE03SFd1dk02ODhLelVX?=
 =?utf-8?B?eEJ0MDlwUHdEWWlwY1lKNWY2R3NKVE1ENkloWm1scWNZcnplWlZ5SGZuMnJT?=
 =?utf-8?B?aW1UMm1ORUJqY2xIY1JUTWR1cVdvSVg2dTI0RndITW9JeElqVnpPa2x2QXA5?=
 =?utf-8?B?QW9yQnlBVVZSL2Z2Z3psV2Z5NFIxeHdNWUE3WnVScGN1MkRsdEVndndZd2VY?=
 =?utf-8?B?QUhlOTFCd1NPc2FsVlFTUXRKYzlLYmJabERoV0gvT2hPQWRDdGNWMHY5SC9E?=
 =?utf-8?B?OGZkWUxuWmJQdTBoRklMVjIxS2pna3gyQWpWWlJRTEtwbHpxRi9tVWJBTFEr?=
 =?utf-8?B?ZVQ2UnlMNTBHUFRhbUdTMGRNclpHWERJajNRNTRoOEhqbEI4cWhneVI2RnFw?=
 =?utf-8?B?QmkvaGlMV21uRXorZmthZ3V1d21LdlYraE9OUnhSYkh1b3I0TERMeHJCWlJY?=
 =?utf-8?B?bzlKdm83TUtjV2lLSmcrcDlTaE8wUmxBb3JKb2kwYy83N0lIR05seUdZQTNm?=
 =?utf-8?B?eTBaYXRidWE1OUxzRm44WWJBOVZFbU1qTUsrOGIzKzJTUGYzYzB6UTFBbUxu?=
 =?utf-8?B?RGhFUTljSW1HZnJwZWlYTk5sZU5RalNCS3BxenVOWmUrdUlybXFBZDRWeWNh?=
 =?utf-8?B?WWl2aWFmRitMdmUvTEhLTmJaSVJWWGFQT1ZwSlZjaVdOZ2xrOE9mMU5KeHdP?=
 =?utf-8?B?bXRSTTBKRU83ZnZQaktzSlhReFFKeTF2Um9pNFRzbzh2OHFHejF6R1hOU0lG?=
 =?utf-8?B?NDNlMXBDVXBsQXYxYmpscHN3ZWRVNHdPYkNnMHlOSTE2bm91UkdZNkg3RVlk?=
 =?utf-8?B?N1E4Z3REOVNscyt1YW4vZ1hoamxBSnliUkxmKzUxa3JMR0VrdFU0ejdjNmQr?=
 =?utf-8?B?WlRxbmRJalJQT2s0cEZEbElCcU9XQWdpR2dncGtuV1hyd1cxQ1pYTVFIRUIr?=
 =?utf-8?B?d25JVXcrbGxyUUEvRm4zdEVRaXJ6MUczallHQWZXd0hrdjVwTllONXNsM3NG?=
 =?utf-8?B?TGV0TlRSZEY0TGxnbkRHVkN1S3NHY0JIaXBIV1oyZzVmSGxDU2pwckhydFZR?=
 =?utf-8?B?SHBuSFFTb0hsSXRrdGVNTVE4SzhCbHAyY3IwQnA4aEM2bkUrNWdMQVNxUjFF?=
 =?utf-8?B?NENCc0xkSUNhaEhwTVN6bzd5dXBZQWhEM20vQVNkeXpNRGtXZlV1Z0FoaUlz?=
 =?utf-8?B?Um5rMmdvOGxWdzlwWENRbjQraVZqdGY4alRERTlwblV0bnNIMHpLdWdVN1Fn?=
 =?utf-8?B?bU5FVmZDaVpCbXBJV0xaTWUyV0FGc0pDN3RiNWk0Z2xiSUx0Y3ZYc2w4aVdL?=
 =?utf-8?B?ek5LblFUc2UrSitTV1BSTGl2UERmRXFsbDFJRkpoREpUZjJGbDBSWUthNy8z?=
 =?utf-8?B?dGtQNXBBMUN5ZzNjY2Q4RUxjcm5oMlAyVGJtNmpTSUdaMW41WlpGVXRIdHV2?=
 =?utf-8?Q?sfVp38C4fbCHiskfDwcRPuFRzlPobTBX5viaeHDYi/KG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WBw3kRZNpxGwsKP/F5T55LehzG/MdkSInTvi2BpvjJlfNxPx6WDqpOkPNPrF1CA+a2gK/cZFIxB9tEmaLg8uRuY/wA5ThBh249+XD/8sx5DGnM9L+4UoMxUE2OQ8LddMOMDeeWp/Ng9PHVqQRfJDhSEuPUsfLIuBF0QlsHtBAeOdkPk7yBChezdpzQPUQSZ2TMBeK5LTn29W/Er5E67gB9hpe0a2N9akoM4/MELcMgx5F7vK+GJG3hKbm9iATUZp5h/XPvju/RKF5MkcluD1Lb/nydhk7Br83oyjF42NOKlsUZP3egI2T9J4qj7PKoo6TVn7qd/NAmuyV+otFdaQvtbp22TpQwCLzaUHPacyKaQSlaqk5LV0UdSzzAqYxxjJzPmpUmUEUUFiPHU9Y/Eb0LVVfRGl5ECM1GH2krVLxwqqqdueGbqGB6+aEJ6jpM6BwrbdJeaB/T+98Cd4kFF+Qnvym5PcOQ9NE2r5KQtSwjwYrBTLetBrfKsfdYO5fXfq2mJDeRLB7cI1ltyYD70hBKb1WsfXRak4XEyyD6n5K15+vu49gyxWRiZYHUG79KxPBYZSTAujoyT9rsrZIGnBw5F2HmnRbx0LqaHw/pyfwJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb7e265-2572-4a83-1589-08dc2c3c9a95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 02:36:38.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrVrMLM/1w4v0QzHMtJFu75Y5212AhYEK0QVmwOcokaRhpWIcp96R59DSSPLkiFoKQeWrZM65YJdZUWnAjBeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130017
X-Proofpoint-ORIG-GUID: qcsynaQpvVx4fTz0Vt0ZmL7t26JTCoFa
X-Proofpoint-GUID: qcsynaQpvVx4fTz0Vt0ZmL7t26JTCoFa

On 2/12/24 22:11, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Add the fiemap group to the test.
> - Actually include the reproducer helper program.
> 
>   src/Makefile          |  2 +-
>   src/fiemap-fault.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/740     | 41 ++++++++++++++++++++++++
>   tests/generic/740.out |  2 ++
>   4 files changed, 117 insertions(+), 1 deletion(-)
>   create mode 100644 src/fiemap-fault.c
>   create mode 100644 tests/generic/740
>   create mode 100644 tests/generic/740.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index d79015ce..916f6755 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>   	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>   	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>   	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl
> +	uuid_ioctl fiemap-fault
>   
>   EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>   	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
> new file mode 100644
> index 00000000..27081188
> --- /dev/null
> +++ b/src/fiemap-fault.c


Pls add fiemap-fault file to .gitignore

more below.

> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/fiemap.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +int prep_mmap_buffer(int fd, void **addr)
> +{
> +	struct stat st;
> +	int ret;
> +
> +	ret = fstat(fd, &st);
> +	if (ret)
> +		err(1, "failed to stat %d", fd);
> +
> +	*addr = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (*addr == MAP_FAILED)
> +		err(1, "failed to mmap %d", fd);
> +
> +	return st.st_size;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct fiemap *fiemap;
> +	size_t sz, last = 0;
> +	void *buf = NULL;
> +	int ret, fd;
> +
> +	if (argc != 2)
> +		errx(1, "no in and out file name arguments given");
> +
> +	fd = open(argv[1], O_RDWR, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", argv[1]);
> +
> +	sz = prep_mmap_buffer(fd, &buf);
> +
> +	fiemap = (struct fiemap *)buf;
> +	fiemap->fm_flags = 0;
> +	fiemap->fm_extent_count = (sz - sizeof(struct fiemap)) /
> +				  sizeof(struct fiemap_extent);
> +
> +	while (last < sz) {
> +		int i;
> +
> +		fiemap->fm_start = last;
> +		fiemap->fm_length = sz - last;
> +
> +		ret = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
> +		if (ret < 0)
> +			err(1, "fiemap failed %d (%s)", errno, strerror(errno));
> +		for (i = 0; i < fiemap->fm_mapped_extents; i++)
> +		       last = fiemap->fm_extents[i].fe_logical +
> +			       fiemap->fm_extents[i].fe_length;
> +	}
> +

   munmap() is missing.
   a few more below.

> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100644
> index 00000000..30ace1dd
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test fiemap into an mmaped buffer of the same file
> +#
> +# Create a reasonably large file, then run a program which mmaps it and uses
> +# that as a buffer for an fiemap call.  This is a regression test for btrfs
> +# where we used to hold a lock for the duration of the fiemap call which would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fiemap
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +		"btrfs: fix deadlock with fiemap and extent locking"
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=$TEST_DIR/fiemap-fault-$seq

  Could we pls use:
    dst=$TEST_DIR/$seq/fiemap-fault
    mkdir -p $dst

  Keeps $TEST_DIR organized.

> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done
> +
> +$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
> +


> +rm -f $dst

Pls move this to custom clean up at _cleanup() within the testcase.

Thanks, Anand



> +
> +# success, all done
> +status=$?
> +exit
> +
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 00000000..3f841e60
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,2 @@
> +QA output created by 740
> +Silence is golden


