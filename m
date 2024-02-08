Return-Path: <linux-btrfs+bounces-2222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728884D801
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 03:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A32B221D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 02:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3691D529;
	Thu,  8 Feb 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J4E632/u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XjrPfE7W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F101CD19
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360821; cv=fail; b=UHnE3IUqnkT8oUwCh+tcFpg3jrwdQyVAddM4W996eCIxx2hARBcsgj5NO28cio4kto3dahkvPKhtkim7ibgGVu6sN2TCwHB1+8zHg5AkH7feScr9WxohsRGrMGWInYe3gbjshteuvj2AsqgcqYRrNOgEWy82WZZq4qCVq+JL/qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360821; c=relaxed/simple;
	bh=lWTkF5UCC+CG5NgPlvKxMZfXkvuUrJyqvYIhQLOihmg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EsoMjPXVD8vMAdtxLu1FA+WGh3hgSH9OfzEYaU5GmjxsPHkDVwxn3dOKNd+Af5t7aEq2e1dxd9aslttHM8CHPD9dBwTq6n0xz8CeQDw2Da8QdKMNPQbZve7fdILkkXPzZkWMrRsyXySxxo5tPCcum4H79NAYustEqysCc3xTkM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J4E632/u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XjrPfE7W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417MbUtr024793;
	Thu, 8 Feb 2024 02:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5ZfNuK4AxSrU2UzW3CJ/0egZffhocW15jfuXKfIRAhA=;
 b=J4E632/u6jhFolTwnbg2xrIzWyfH7om6YU8aAleGjBgle/4Yqn/A2UWfXKspdWKlf+SW
 nEcCCXXQccPRR+Aqnralmx3wHJ+JW6kED4MVSaPllwIKhyEKzmNpUVbwqz4yfFB7nHWZ
 aF3URscfL5NUTcpovWOIFS7IWmEshn7bPnOVpg8YYM1q0371Fl4UT1Y+sv8Ic2ahZgYH
 xh6r1Tz/wq79wo/6KtqxjzLjiYvbDICPr+eUUiBnZnRl44HH9xGdlGA12z2HDmPLpAMz
 3jLQOd+LDREyZFRhHr+IkLlgJ0+xjr+I17pIhGZxsmaQGOEMd4+fXlG3m+ENf31tutAn Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ukfm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:53:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4181AGWO039499;
	Thu, 8 Feb 2024 02:53:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9r0mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6mo6YsbQgXIsVLBtzcPfo+N/4HC5OVQuwLHaWmrodIix3a+yQURzzItEzKsmeefJ52NeIPLX8repIUv8ghEYioMv5L20rBuwM1UvIYztxC9sCHXvZ9tlOHdNHjQe5U5AmTIWarFESgbh3lqaPbVPvjoib82hZu838X6+Cz/qrFqLADesx5xe7xzyhY17gkd7t3HNjFf+RKvuQ/C1E4vPjfRKCNqHMQ3Ug4h0/MTgoLb+0C6EvYI5DvptOyCLP3SznjEaESRxSdwnoXKlfhEZWuEs72nFybbkrwUYA1oXAULD5zUDNZ8PG80n8tg0jxSWvTEURenD9bYa+x6QIEm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZfNuK4AxSrU2UzW3CJ/0egZffhocW15jfuXKfIRAhA=;
 b=W5Dse+tx6pVerop5apWD/V1wvycwrFPIe2NjHjlaXlMQC0v2r8Ta2vn/3VNzIW9+qz7p1MQiqIAQdEztM56TxZJpANvkV6OdKs1aYgwWafcnsmDoGMjDUHN6h/AthDh9J3RaVVE1VknjsVmhvRntfy4+POHBfbl1cNljzVujVNeb7HVI/NiA/IYpE0e+7uY1eopSlmkmqbpu6Q/FgShDlh8gaLgS10F7i34Y+SvW6QlrJDS3jL3ZZaUhogWaCvi76sf3cKPopPRU5dP5qROmTFSlvKsqMxfpLfU5umCsTNzmFwlv6xgorW6QsLCMKzfvqiy401bQKPcYVSvzM+9ALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZfNuK4AxSrU2UzW3CJ/0egZffhocW15jfuXKfIRAhA=;
 b=XjrPfE7WKLPdepXb+zAglEDhdYb+YvcfwUEXnGOMwvL+A4O16jvBNh99OErpUf8g7dDBbHfJT0gZoKkronRZEb9tSLCxVNp0ArRpKp5bx3yP49XDV2h0m2D4RsoouB9jmJDPl2iqFz8lL8nf2C2iJkT4xHSm4bk3g7/KiZjtVIY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6763.namprd10.prod.outlook.com (2603:10b6:610:147::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 02:53:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 02:53:24 +0000
Message-ID: <0b10c270-b08e-41f4-9673-449226e3f218@oracle.com>
Date: Thu, 8 Feb 2024 08:23:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: fix the stray fd close in
 open_ctree_fs_info()
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1706827356.git.wqu@suse.com>
 <abf545db2a21d27c02f92b8a3be0e836fbd3cdd5.1706827356.git.wqu@suse.com>
 <d8484431-72b7-4fe4-a4dc-264f82af7c22@oracle.com>
 <31d07ebd-0147-4761-85fb-5d07e67a6b0e@gmx.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <31d07ebd-0147-4761-85fb-5d07e67a6b0e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 97458511-422a-415b-8036-08dc28511e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QJnZBNydPOe9ZCjG3Q5BO8fKXUVD4jTmj+qdPXqOs7ieee/Aftyv9pVl4n7BOVhgt5yxDzNJQlJEvh7PjjG2LqCO2AQrr/seaZYitALSvC9JEOJlUHwmdIzhGX/aanGP2TzOaeLPyR9nrwFpOPM0j9g1xf5JlNjQ8y8SPeVmAv0rpzTyuw/EIDbJK0KFRm66io8cdVrGCZzC/LcGaPlKvQvElQs7+Pdr4qnOG1oczY9SrhXbfrTarX9zJhhh/e1u8fPsCXNk93GssJam4kqQP7juLnTSSsn4Z1DtKf+5VEXDIpcnVVYt3CmFv9zPiGd/sWJMTLfWq0JRRhHBQYPQCeC9mC9BW3GE2Fmn729hV9y3sjvCKN6Rf/VC6635VFMNGbxGIwrZ6SvqULzrsjr8XUPjP/apZGVHhy5tJmKZ6Oved7wCPTW1hYibt6quAwDvAKnxA+nOEobzEoaA01t3fWg9fTSkDhPT5l1VAUJu/AEMYVpMJ7MvMWb+AF7KFt1mO0wb1dgGz+xS9I+cDc8GYBXXtTrk59EjuD3dL2IGwWk9VupmJ7m/YQJuGwFq2VcF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(38100700002)(83380400001)(2616005)(86362001)(31696002)(6486002)(26005)(6506007)(6666004)(478600001)(6512007)(53546011)(36756003)(316002)(41300700001)(66476007)(66556008)(110136005)(66946007)(8936002)(8676002)(44832011)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkFpMjIzRGUvN0lSa0JyOEFZWnFEWDBvbnFkRHlWVDMwaW5YUWJ3YXJxdzBW?=
 =?utf-8?B?VTJhZGxvQ3ZWalpKUnMycEZjdWJETzVIN0JKRml3YnovbEtEejMwTlFvYXg4?=
 =?utf-8?B?Sk9RVzVWRUJxK2VCQXFzNlROT0VWZVM2UGYzeGljN1BybmZRTjNXM0dWQWJZ?=
 =?utf-8?B?Nk1BWURtRDR4cGJXbUswRkJDQThsR3RoR2duajlxZTdnb09JTm9lY0ZNa1BT?=
 =?utf-8?B?Ylp6VWlTc1pPYlZ4RW9QWjNQRlJ4N3dwRzBVbEpTYjk1MlAxZUxiaHYvamZV?=
 =?utf-8?B?dDFEVHlkNEJra3FXckJBU1VKWUhEdkY1R3lSUTRiRmx5WTROT1FIcmJmeVkv?=
 =?utf-8?B?WWt1Q2x5YU45dmlCS3lkTklGdm5mTzNZMk5MVURnd0VnbWdNaHBwOXgzYUN0?=
 =?utf-8?B?RTBUbEp0RU9lYm5ub0FmMUZMN2FSRFU3ZVZjRGpCQ2lTMU43UkkzRkl0ZXNt?=
 =?utf-8?B?ZEFUNXQrZmdONTM5cmhiZXhGTFVhYkhJaFF1VUZ0NEdReFJoNlFvVkdEbGVP?=
 =?utf-8?B?dTVBOGRwUHB1ZWFKazNyVDRqU003UmM2QjVLeWtOT095STNSeHV2VEVmU1J5?=
 =?utf-8?B?bFczeFpZeWVpS1dmMVBpWkV4SlBzc2xFMjBqeWZ5VVF3b3BKcE9BN3BRdm02?=
 =?utf-8?B?R0Y5MG11ZDBvbUFNQm56Rko5aWQvODhqa1pwMXdRMS9HZXpJQTNkNFpFS1ZS?=
 =?utf-8?B?QkRqV04wVHhnaS9keE1ESEo3dkkwZUdVVFU1a2gzL21JUkh5RG1wUHhEVkww?=
 =?utf-8?B?ZGRrd3RhdG5Jak1GVUlWVy9uMC8yWGEyd1dNSm5POHNNbkZnRTErYW9KbkJw?=
 =?utf-8?B?VlZtV2gwN0gwRTRhTVZmYUU2amJyczQveUpHNTRjdlBVanQxVEtiemNBcUMv?=
 =?utf-8?B?aWpEN29zMzBDM0kxY0I5Z0RHKzN4KzR1SksvcGhqbm9yVWd6MmhPZVBWS1Q1?=
 =?utf-8?B?QnlHKzVtSDFueFFvbThKMEtPSGFXSXpxMFo2VmxydHZkeDFtRms3d3VJREwv?=
 =?utf-8?B?KzZpNWxRNkZRUlVYSHRrSkVzQ0l2cVJaM0FLeFd0NjRaTzZQQjZRdGZWeVVv?=
 =?utf-8?B?MEoxcFBHQXYvcDhlRFFJSnJtblU0U0F5V1V6VmR0aFlZeTdIdnB0QUkyUUpq?=
 =?utf-8?B?ZlUxRGxlcFJFcjNLY2VIQk5SNi9jbEJyMGFubzNUM1FUdUtIaHJvQjF4cmVI?=
 =?utf-8?B?ZUxKa0MwOFdsVjFETlNHbkFIWWNZaVMwY2xqSS8xUGtLR1k0ZWhKd0xzQU9y?=
 =?utf-8?B?eVZrMjdBb3FBbVl6NmJ5M0psR0NkR0dzd2kyZTNhaVUyeDdscXk5RTJBSnk5?=
 =?utf-8?B?V1BMVVNCSXlJR245RnF0bVkzZ0hwb2tpMEdIcHAzNXlWN3lNREh0TW9yVHdm?=
 =?utf-8?B?N1R6TWoxTVN1eDhZWEFXYXRDUStmd0tvRFhhUWt1VVl0RWdNQ0ZsZ3dySm5z?=
 =?utf-8?B?dEpLRVNEM0FRSGVjc0FhLzJaMzdIZWg1R3phYVdlTzNONWlyaE5mMmI3UnRH?=
 =?utf-8?B?QWY4eFA0QmdhVE94dXBhSU56QkxmWjIwTnNOUStJNmNRZ0pQL1lnZXdOMndu?=
 =?utf-8?B?VjFNL3dPSm1hQjZzdTVMMU4ydnBJYWZKTW93VGRMSU1YZGpoNmszVXg2ZFpo?=
 =?utf-8?B?RER5a09FMWZqUTkwc2I3YUxleFJDOEJKYUk5TjhVNkRYL0lpQ0RQR2lFSG80?=
 =?utf-8?B?NWVoYi91eGVGZFRWMkRnTEo3Y2hwOG02Z0hMTWZSM2xVTXdJWUE0bEQwRUh0?=
 =?utf-8?B?Zk10Z3ArckdRZUxpemhTSTBLQzlMa3JaT2xyY2VpSGpSM0lWckJRMTlHSWoy?=
 =?utf-8?B?Y05lWEN0bnNXcm9hS1lkR0NpcEJyL0pDajlmOXVzK1YrZUY4Mmw2Q2sxSnc1?=
 =?utf-8?B?NGJLZ1NrTWRHTXZiMUxHUGRkOUVIRVJBdmkzL0dVL3g5Y0NLS1BwTjlqa2hi?=
 =?utf-8?B?UzYzNzlQb09wTklPeVRtenY5T3o4a1JzaGkyZEdDSTh2WmR6bjJCOUtXem1p?=
 =?utf-8?B?Z3lLYlhSWG9UbGdHTnhzUWRNbWx0TlRPQWEvL2VMVnlKdmFBdGE1Q2xCMVFV?=
 =?utf-8?B?NmplVDVkYmd1cTJ3QU96U0FWVXJUUDg0bGYxcGFEMnFWVWc3V2YrYWxTZThl?=
 =?utf-8?Q?sNGyKg2SwyGfVEc439+ab8hPC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DPj5mcDy7tLYfvuzr/RmfHtyBG9XM7YwoMQpVgjFH62HuS1TgAa+BfQtAV2eZxGWWDYmUqU4d9HhDy0ZIBsBIaN1a0T4lxiF2sFwU/BAqsKnEEaXRi3ZzHYHdcaPb5GCwhOOOp0y/pjlZGc/9WlDpIqXU5qCPz49T7PtxIO3Agfk5t+dWsMW+kQuwxpO+gjDcpSdVL7jzem7JgmmLlG6K06wJZQ+HXi8jApksDY1k9SNLtE8AxG4MblsrMvLB7w3IQPRQ4GjDANXW0ye3F2psUtbZrf83/m81USmcucQC+AEApfGLuWtk8ZJUuBg5r74FmdABRQuMgpUegKJqG/w88xYon5pwx8ApMdvPrgJlZf1COteU8lWTc6nvH42OT2kl2nGanWFi1jPDcXS6LRtIFymPG94G7GJhOgZ2Ddb4v959rkYeOXlTxIDBlMoPx6QKJFd1nopzOXJbtzdS+CH5x9MTqRegltDU09nW6kDy4EKCNX4/BH7XDV5SCPXo3thXQd3ZoJ58L2uI9YspgiI5PdtG/WrnbQZCmghDpLrwolaNfhQD3tgpgD6ycWOc0O9EYbxvi3BNUT+df3qXQJUcIOIZrgBLGlVSLMw0FXWszc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97458511-422a-415b-8036-08dc28511e3a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 02:53:24.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWQk4EhdxAmZI/gN6l3yvcC0Xl+cyh4jtjAvJGReL7IvwZyTd9avX9pRmYyEWsePQWqZJc+7UR0zbNuePj0GvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080012
X-Proofpoint-ORIG-GUID: 4Ws9sXPVo19lSIz3ofP74uAAdEnJOQgl
X-Proofpoint-GUID: 4Ws9sXPVo19lSIz3ofP74uAAdEnJOQgl



On 2/8/24 02:35, Qu Wenruo wrote:
> 
> 
> On 2024/2/8 03:06, Anand Jain wrote:
>>
>>> index c053319200cb..05323b2cd393 100644
>>> --- a/kernel-shared/disk-io.c
>>> +++ b/kernel-shared/disk-io.c
>>> @@ -913,6 +913,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int
>>> writable, u64 sb_bytenr)
>>>       fs_info->metadata_alloc_profile = (u64)-1;
>>>       fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
>>>       fs_info->nr_global_roots = 1;
>>> +    fs_info->initial_fd = -1;
>>>       return fs_info;
>>> @@ -1690,7 +1691,10 @@ struct btrfs_fs_info *open_ctree_fs_info(struct
>>> open_ctree_args *oca)
>>>           return NULL;
>>>       }
>>
>>
>>>       info = __open_ctree_fd(fp, oca);
>>> -    close(fp);
>>> +    if (info)
>>
>>
>>> +        info->initial_fd = fp;
>>
>> Why not do this in __open_ctree_fd()?
> 
> Because we want to keep open()/close() in the same layer when possible.
> 
>> then in the parent function, __open_ctree_fd you could:
>>
>>      if (!info)
>>          close(fp);
>>
>>
>>> +    else
>>> +        close(fp);
>>
>>>       return info;
>>>   }
>>> @@ -2297,6 +2301,8 @@ skip_commit:
>>>       btrfs_release_all_roots(fs_info);
>>>       ret = btrfs_close_devices(fs_info->fs_devices);
>>> +    if (fs_info->initial_fd >= 0)
>>> +        close(fs_info->initial_fd);
>>>       btrfs_cleanup_all_caches(fs_info);
>>>       btrfs_free_fs_info(fs_info);
>>>       if (!err)
>>
>>
>> Essentially this patch converts the following nested open close
>>
>>
>> fd1 open
>> fd1 write zero
>> fd1 write temp-sb
>> fd2 open
>> fd2 read super
>> fd3 open devices
>> fd2 close
>> fd1 write temp-sb-to-remaining-dev-if-any
>> fd3 write good-sb
>> fd3 close
>> fd1 close
>>
>> to
>>
>> [1]
>> fd1 open
>> fd1 write zero
>> fd1 write temp-sb
>> fd2 open
>> fd2 read super
>> fd3 open devices
>> fd1 write temp-sb-to-remaining-dev-if-any
>> fd3 write good-sb
>> fd3 close
>> fd2 close
>> fd1 close
>>
>>
>> However the patch
>>    [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
>> mkfs.btrfs
>>
>>
>> achieved: (And reduced one less fd)
>>
>> fd1 open
>> fd1 write zero
>> fd1 write temp-sb
>> fd1 read super
>> fd2 open devices
>> fd1 write temp-sb-to-remaining-dev-if-any
>> fd2 write good-sb
>> fd2 close
>> fd1 close
> 
> The problem we are hitting don't care how many fds we opened or
> whatever, as long as the final close is later than the final fs commit.

Indeed, reusing fewer fd is a good cleanup.

> 
>>
>>
>> This patch saves the temporary fd (which is a helper fd to read the sb.
>> fd2 in [1]) into a new member fs_info::initial_fd, does not make much
>> sense to me. This fix is a kind of a quick, patchy solution rather
>> than a ground-up clean design, imo.
> 
> Nope, your version needs all caller of open_ctree_fs_info() to converted
> to the new interface.

  It is a step in the right direction.

> This one keeps the interface untouched and still solves the problem.
> 
> Yes, this can be enhanced, but not in the way you did.
> 

> The proper way is to make open_ctree_fs_info() to not to rely on any
> external fd, but really make open_ctree_fs_info() to only open fds for
> its devices.


It depends on when the parent's fd is closed. Sequential
is better imo (See Josef comments in my patch), keeping
only one fd open at any time.
David's concerns about excess udev events and calls to
btrfs dev scan should be fine for mkfs since
no good-sb written yet.

> This would make open_ctree_fs_info() to get rid of __open_ctree_fd()
> completely.

It's a step forward, but adding another member to fs_info
for a helper fd as in this patch isn't wise.

> That would be a large work and does not provide really much benefit > compared to the current workaround.

Improving open_ctree are more in line with my patch's goal.

Thanks, Anand


> 
> Thanks,
> Qu
> 
>>
>> Thx. Anand
>>
>>

