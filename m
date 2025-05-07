Return-Path: <linux-btrfs+bounces-13796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBDAAE6C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8F7BDC5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6D289E21;
	Wed,  7 May 2025 16:33:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2105.outbound.protection.outlook.com [40.107.241.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9AA937
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635595; cv=fail; b=Wgom7yiQHNSHVDKDmWYIrx8m2c+LIBDayA9G30zP3tt4vHZkLbQ8MQycCg8hvqGUGExxxWorH+zm8IxaKj9yedJDHSm1v55GfFHICqhV9WpHtMXf1VG2mVh3gWK+vT+F1Vt1HwhUZChKcl2dz6X+KsoFTtM9HKyAqq34+DBclu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635595; c=relaxed/simple;
	bh=C8epZvuYT8w9XnbPi5w/qHs8vC9JusGdbmPgrucH8+8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=bu1Y3anEjF4DZaTgGIues8BVKxq0ybI9gNb1t1LJWsLWPuR9y00mhM3sNuxBbQmOfIq2u+car6OV1IrfV8D452GpY+BqIpMZkTPuPez3KnrWxUqWKYnd7ie+xacC/Vh5/4ccFZPtPQPEXfbJedICwmOAlZNEdUWMgWbxt3OQv30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucis.nl; spf=pass smtp.mailfrom=ucis.nl; arc=fail smtp.client-ip=40.107.241.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucis.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucis.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX1dIaNeYiLu9x7wsRFMvqtQcMI5YOHWTI2X5rQX7htz7vsxOhR9GtngOXoeh20Zzi41kn/egF9H4zj2JMqMmpfSbftfM21APoYH0q7E77EOgPl4HWUUjEi8dyDIfHrshc+t+mgLPPnhnELwT03H1nMjvgdWC+XxB+QrDOYLyswdGq9KB9WlI+TpWZjddwii2s+zTiHUr6AGT5EtWaCs/l+nOAxIWmVwIzCuQdLAepGtXj0bQffhx703OofaqYRD9HDPr97RWmSSO7Hgb18hIB7u2xfFYJHUejrRk3RoxQhDu1Lnxra1aPfzz7hCMVGpZYz8d7pYszb+cqVc+oeFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acYnLJIbdJDJoMda3aWBmNV1AbR13rrx7Csos510hXs=;
 b=nK5kftlYQ5R/wJHCQM4CzlAYAx9317whVTZJNY+e12PRomK/4oYnJ9jr/oKVuX13WoBNyXHiuA8POjAprNMYB12oKh1UNzXvsaigJSqcWCBG8d9mAt1t9pEluJQPqnQmfjfWb/8E0JJ3XFNXIl4N4L/DHI9GKe/mh6Vj6TPMUuppj8JNtTOWXqCtUasS35mDegcjjbppnVkAtp9I1yzrKqQdXcBSEr1/1TsyTkZNlhklPa99D9RreZB7sJgvsc9fRdi+8VrLCZuPMqdIZYjwGPtf39RJixYTRuVqlTyJyfHi7BGOcDOe5oFQwSrOLoOU5oEUbS8DIsS6EmW0fEMuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucis.nl; dmarc=pass action=none header.from=ucis.nl; dkim=pass
 header.d=ucis.nl; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucis.nl;
Received: from AM9PR03MB7946.eurprd03.prod.outlook.com (2603:10a6:20b:439::23)
 by DB9PR03MB7196.eurprd03.prod.outlook.com (2603:10a6:10:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 16:33:08 +0000
Received: from AM9PR03MB7946.eurprd03.prod.outlook.com
 ([fe80::d5ce:3e3:5843:d6c2]) by AM9PR03MB7946.eurprd03.prod.outlook.com
 ([fe80::d5ce:3e3:5843:d6c2%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 16:33:08 +0000
Message-ID: <507f3dd3-1148-40be-8223-87be96ac6269@ucis.nl>
Date: Wed, 7 May 2025 18:33:07 +0200
User-Agent: Mozilla Thunderbird
Content-Language: nl
To: linux-btrfs@vger.kernel.org
From: Ivo Smits <ivo@ucis.nl>
Subject: parent transid verify failed on raid1
Organization: UCIS Internet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::19) To AM9PR03MB7946.eurprd03.prod.outlook.com
 (2603:10a6:20b:439::23)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR03MB7946:EE_|DB9PR03MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c71b79e-71a8-4a24-a53e-08dd8d84d98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cktodnZFNVl3cDFucncvSUNlcnJTcEdKNWdlUlRVNXc5VGNEckhFZXFsSkZN?=
 =?utf-8?B?Qm5HeG5hZTZwTGptMm1vaFAvNEticzJGVW8veGVJSlh1VWhtSWdUWHRoRnNv?=
 =?utf-8?B?WjEwVE81d3k1dHJaZWthQ0RSWDZxK3BFVFJ2T2pHUXdWNzJ3Q1dXZmNtRk1E?=
 =?utf-8?B?bERDT1BWY0pUWXhEYzBDSWt3M0NlRzNIVFFKamtvV3pnc1AvZmZ3eHpIWFIz?=
 =?utf-8?B?a3k4RHBBazFjRzd0K1NyazlCeFhCYy9EVU9wMXpneEc1OVNvdHkvNm05eHFR?=
 =?utf-8?B?ZzBpZ2JrcHNQdkJZeDBVdGFveUhPbkRvNHFaQkdjNTlISkNCM2dQOTV0NElQ?=
 =?utf-8?B?d1VFUll4ajltNndYTE9PbFp4NHphZHJNU3NiTkJVT2hVTy9Wd3UwWkQ1Sjh3?=
 =?utf-8?B?WGZ6YURKWTkySjcxRjFnNmM1V0p3Uk1Zd1VNOSs1citUYjVzQlVxM0d6b1VW?=
 =?utf-8?B?UFQxS0FTd005d1ViVk9tWUJZL28wYXk0MC9OTFJRY01oSkhqRDRPSmsrVnZU?=
 =?utf-8?B?dWZUZHFXejJhYTlCMS9YSUhLTmJKNnZWRy9DRi9PVzRPcTc5SFVCU3krZ1VQ?=
 =?utf-8?B?MG9SSHZiU2I5OGp1YkhDbDlVcUx2M29naDRhN1ZqVFZSeE1HSGxPVmtjaTBD?=
 =?utf-8?B?cEMyL0NUaEhPRVFybktCeDZjRm5PTlV1anA3NDE1d1hwZjd1aU5wZUJPdENt?=
 =?utf-8?B?WEd1UE1taWVMdlMzME9VUVVLekE4LzZXZmVDYVplakgwZjVtam1FanVyYzFn?=
 =?utf-8?B?cncyTXphQUp2dFdOaGdHN0EvVUtWTFROamhiOEZ4VmZwSjUySUFlM1pNMzRY?=
 =?utf-8?B?YnA5eXdTMEdyY1pEcjZJWEwvdENraDYzY2JyVG9xMkpKL1ovY1grVkVTSWty?=
 =?utf-8?B?VFpWNnY4dFVxSHFSd2Q5MU5nc1M4djAvK1FRZHcyQ2xKbDNtcWc0RWd5Wjll?=
 =?utf-8?B?SFA4ZEtVMkIvV1BSWGU3U1Z0V2VqSkhrTm5BM3JrK3JHUW4yR1ArKy9UaWxU?=
 =?utf-8?B?Rk9UVlZkYjdUbHdHSitlNkZaUFhhVkFkNWNJa3ZvbmZBcmZKaFIydjNDaGJ4?=
 =?utf-8?B?RDlPMWtURUVGRldOcGhwQUo5Q2Q0bUJkU3ErRmNVVnRDakNNMG01SHI1SnJv?=
 =?utf-8?B?T2FOSmRsUlhjalc4YXMvQ2FZTk5OMUtaUVBRN1VjMkRqVVAxQmZZRkh1Mlla?=
 =?utf-8?B?WXl5aTR4YmZJNFRNckxtOWczWnZhMjY4b0NoamlLKzFrdlVMMHI1eTQzWmJn?=
 =?utf-8?B?MU1sZGhTalNScEhzb2VuZXRoT09FYzIvSTFZaUtRdDUrZXo3QzM4YnhnTnpl?=
 =?utf-8?B?RGtLRnZOZkQ4emo2Rk1JMytiVnJZVEJ4Rjh6c2Npdk80U0RYWWZjbDlDVzJn?=
 =?utf-8?B?eFhiMjkrOGZKbjkzeVNiS1Z4RXBhNG9ydUpnTjdpNmlyRGNFVFNVQ2JwY3h5?=
 =?utf-8?B?V1I1RmhiT1NyYnlNbWVrVGN0b3Y5VGVUNDYzekpCOW5xbFM4WldTWm5Oc3pB?=
 =?utf-8?B?c2U0MHhUSDVxcytGT3J1TmRWNmgyTUdHWDhEalA5NlAxeW53SUZqcGh1RENT?=
 =?utf-8?B?V1V2Q05IMUliZmdFdWxyaGQ4TUhFSzBDK2pWR2I3ZEZ1dm9hR1Mxb0FURUZt?=
 =?utf-8?B?cWVRelNwK3U0L1lWdHY1RldBa3ptQjRob1QxUXBrNytCcTRobWd5ZERXYnF3?=
 =?utf-8?B?WldtMmhESGV0aFYrajVHNmZoQnk2aXpmSGFDQlhvUmw0Q3U5dHpDcjZtQkRr?=
 =?utf-8?B?TW9temprWDN6R3h2TE5YaC9zTG9UTGl6RXNFRkdPNEY5c1FXMXhJZHdLYmZs?=
 =?utf-8?B?MHJ3WUl6NlFTMjJrZGhmUjdYSEpUOEhHTnpCbldFcXIwd3VLazV0T05EMTlR?=
 =?utf-8?B?SHIrejZ4ZjJ3OVZERWN5WTB5K0E2d29reWdHbk9TLzlnbk9zSVpqQ0hsVlhP?=
 =?utf-8?Q?zwBNNyKHAbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB7946.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzVMK0xnMStLT1NOL1YzRmdvQVBTZmJmQXczZFZnZGM0Wm83OHRaNnN4RFdr?=
 =?utf-8?B?dHNWd0ZVU0lMVmliUmwxMVhseXJNK0RMS1UwSnpJSXV0cVlLVVlKQ3R0VCtO?=
 =?utf-8?B?SnVLMUFhejJhbTFLUVVLM045STFvcitQU1E1RGtiTlRpVVlUdTFaOWtqSStk?=
 =?utf-8?B?TlVNWVFMMnViYzY1Uk1IYnRHL1pWUzNrS1BTT1hwOVlGaHd0ZXpsU0pxdUlY?=
 =?utf-8?B?Z1dOZWsxVU9WZHBtUEpudHpHYi9EMXBOWEV5ZlR0N2k2Nm5qbllTWmpTSVFN?=
 =?utf-8?B?TmZGSEMybGgweSt0Nkhqa2NsRmJLWTJrcmxnWVlSb2xEVDNhNWljalphdXI4?=
 =?utf-8?B?RUFIYXpMWVhVZE9YUzVjN2dNWXNvUU5DSU5YOTNqbjY1bW1EZUxyK09ucU5t?=
 =?utf-8?B?Vmt0WTJKWmp0R3BYaGFQQkpOdWhZWVUvbC9iY3VCWFBjWVpCc1htbHZZOGl4?=
 =?utf-8?B?WnpIL2JJakgxNmRXcXI5QXRqM3NrbzlDOHF4WlpKbk05MmpEUjJQN0Jyb2ZX?=
 =?utf-8?B?UFJtU09heEhLT0F4ZkNQL2xORllBVEYwaVl2ZDN0L1FaR3pOKzNvMkdYK1hz?=
 =?utf-8?B?YU0vc3RGbmlFcmxmUnhhNWJ5aEpmL0U4eFpOQWZ4TFBEMVIxMkx4YXB0Y1Z6?=
 =?utf-8?B?YVdyYnpSUG9XMGx1ai9DVDd3UDRTVE5NTDRKcTJnYzVpWmdPNzhDekt5SXZ6?=
 =?utf-8?B?T0IvQjlwKyt1V1JSK0JaUTd1S3lUVDdWTXNEYlhRWlV3dVBVdzZuMFBpc0Nk?=
 =?utf-8?B?aUNVdWxnazhualI5YW5BRXE3MDhtRkVEY0IzT2oxSzdOZkpxaS9IbDd2K0ky?=
 =?utf-8?B?TGpwcTV3bVZFeDFtallEU2V3QmRSZkdrbzI5RnI2OGJLYmYzU2U0OEpiTEU4?=
 =?utf-8?B?d1hzbUlzT1JURXhWL3BxOVpza2srblY5V3B6Um9GMFRVYXVnRG1hd2NLWWt0?=
 =?utf-8?B?eFkwUUxpeW9KbHdKcFRERGNwRjZtMEZOcS8zOFo1bXZQWUJ0U0F5UUF0NHNC?=
 =?utf-8?B?M1RZY0M3ZmtHeDlGM093a2FOcFNWWG1jTWtjdmZPRlArMTNvVGJ2WHN4WHlJ?=
 =?utf-8?B?aWthL1BoUC9UZlptN2k2Q25RVWJ4SXNpSTM5YzVOLzkwUExHVzJGL3E5alg4?=
 =?utf-8?B?aFlzSStHZlVSRkJFTTlLSWc1SHdrUU9FYjNocGtsb3pUSUlaUnZiSVNPMk52?=
 =?utf-8?B?UFNFbVcxWXJHR201UVVnME9iYys5K29VUml6dlpwcnl4UGdQSzYrR0Y2eElu?=
 =?utf-8?B?V08xMWExM0lySDRtWjdScWdOdVdmbHNuMGM3SGlYdHZjMVRMZlBHLzNBcURq?=
 =?utf-8?B?cmpDeHBHUkZHR2U0bytsYW00U0VCWWxLRjBJcjB3M3hGdEV3NTRrVXZDYXFX?=
 =?utf-8?B?blMxc21DVkRHUkt0UEpwczdQL1l6dGxFZENBbW9QaFJiMTRTbEdVODQ5L3I2?=
 =?utf-8?B?SmZTbWlOcnB2a1IwQTVLaDU2MXdEOEFGVWRKL2k4VERzSFNaMUQyMHRSNjZz?=
 =?utf-8?B?bDdSZlpHd2dsckFkYVpldG8rVlNRWTNpUXVCamJFUi9ZYU1DMVg4SnpYOUw3?=
 =?utf-8?B?RGFPTzNDR3BYOERXeFQ5anlLOHI3T2kzSzB3NjRGYlZ1VlA3NmJyOEt2aUNK?=
 =?utf-8?B?UHh0ckJyTVpBVUJSNVNNeTk0cm9aNjU1c3VpQ1grcVpNRCtpaldhNDRkWjNN?=
 =?utf-8?B?VmtjL3RVd1doc2JkdHNqVHRlaE44UEY1dWsrREwvaURkb1BITmc4cTQ1VjVs?=
 =?utf-8?B?VVFzd242N05KZzZkL05NUkR0Zm9GZ0ZwMXg4M21pSE5PUEpUd1ZXRWk3QmVw?=
 =?utf-8?B?bjA4eno1YTlWZCt1SUI0YnZ4Y0ZkR3pleFFkaTFFSnVZNy9XRWtzOWZlbVJQ?=
 =?utf-8?B?cWIrQjduZWdpTWV0UEw1bmNCNHFFSGw1ajFyaGFlZFRjbTdvb0tPa3lBY2RI?=
 =?utf-8?B?R0U5cWxvTmRhOS9pWUpPU0dPZGhTM1B0bXFiK2tNczFzdFVhVmFmYTBZSFNB?=
 =?utf-8?B?a2sxbFp3Ry9mVEJJa3MvRVA3dmhzcVJmUVNmMjhMdVdLd1RhQjZtWTBJY2ZR?=
 =?utf-8?B?WFBueWgrcUU5Z21LTFErQlZaU29TTXpIdHMzd3V6YTFaYnJ0S0VQS0Q4emtL?=
 =?utf-8?Q?YNxY=3D?=
X-OriginatorOrg: ucis.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c71b79e-71a8-4a24-a53e-08dd8d84d98b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB7946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:33:08.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5cd14558-8869-4358-94ce-83ff52415861
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wedJjVHHJO1btlH5kklExv/mXgOguBwUTMLkaU4I/qXvJTlmf5eHBErTFFW4oM0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7196

Hello everyone,

After some abuse (drive going offline and unexpected shutdowns) one of 
my fairly large BTRFS filesystems seems to suffer from some corruption. 
The filesystem still mounts and operates mostly fine. A lot of errors 
(probably caused by a drive going offline and later returning) have been 
recovered from a good RAID1 mirror by scrub a little while ago, but some 
problems persist.

The kernel log is repeating the following two messages about every 30 
seconds:

BTRFS error (device sdg1): parent transid verify failed on logical 
31419461632000 mirror 1 wanted 1240926 found 1089963
BTRFS error (device sdg1): parent transid verify failed on logical 
31419461632000 mirror 2 wanted 1240926 found 1089963

I suspect this might be some background process in the kernel trying to 
clean things up since it starts after mounting and doesn't stop.

While all data seems to be accessible, some filesystem operations (like 
balancing partially empty blocks or reducing the size) block forever. I 
suspect this might end up waiting for the failing maintenance or 
retrying indefinitely because of the same error. I think an older kernel 
version even remounted the filesystem read-only when running these 
operations, likely because the transid error produced a different error 
code before (I/O error).

Scrub reports two unrecoverable errors:

BTRFS warning (device sdg1): tree block 31419461632000 mirror 2 has bad 
generation, has 1089963 want 1240926
BTRFS warning (device sdg1): tree block 31419461632000 mirror 1 has bad 
generation, has 1089963 want 1240926
BTRFS warning (device sdg1): checksum/header error at logical 
31419461632000 on dev /dev/sdh1, physical 4363721801728: metadata leaf 
(level 0) in tree 29210773045248
BTRFS warning (device sdg1): checksum/header error at logical 
31419461632000 on dev /dev/sdh1, physical 4363721801728: metadata leaf 
(level 0) in tree 29210773045248
BTRFS warning (device sdg1): tree block 31419461632000 mirror 0 has bad 
generation, has 1089963 want 1240926
BTRFS error (device sdg1): unable to fixup (regular) error at logical 
31419461632000 on dev /dev/sdh1

BTRFS warning (device sdg1): tree block 31420155953152 mirror 2 has bad 
generation, has 1090179 want 1211718
BTRFS warning (device sdg1): tree block 31420155953152 mirror 1 has bad 
generation, has 1090179 want 1211718
BTRFS warning (device sdg1): checksum/header error at logical 
31420155953152 on dev /dev/sdh1, physical 4364416122880: metadata leaf 
(level 0) in tree 14366209343488
BTRFS warning (device sdg1): checksum/header error at logical 
31420155953152 on dev /dev/sdh1, physical 4364416122880: metadata leaf 
(level 0) in tree 14366209343488
BTRFS warning (device sdg1): tree block 31420155953152 mirror 0 has bad 
generation, has 1090179 want 1211718
BTRFS error (device sdg1): unable to fixup (regular) error at logical 
31420155953152 on dev /dev/sdh1

So I tried to locate the affected file(s) for the problematic blocks:

# btrfs inspect-internal dump-tree -b 31419461632000 /dev/sdh1
leaf 31419461632000 items 1 free space 13458 generation 1089963 owner 
CSUM_TREE
leaf 31419461632000 flags 0x1(WRITTEN) backref revision 1
fs uuid b044297e-9527-4d22-bb66-c09206ad8aa7
chunk uuid 943d34f6-586f-414f-91a0-67b3f04e2feb
         item 0 key (EXTENT_CSUM EXTENT_CSUM 36776010444800) itemoff 
13483 itemsize 2800
                 range start 36776010444800 end 36776013312000 length 
2867200

And then managed to find some filenames for the specified range using 
logical-resolve. The filenames pointed to some old backups, so I decided 
to remove those subvolumes, hoping that btrfs could simply release the 
corrupted block. Unfortunately it appears that this did not work, 
logical-resolve now fails because it can't find the referenced subvol_id 
and the kernel errors continue.

I also tried to check the other corrupt block found by scrub. This one 
seems to have a lot more items so might be more problematic, but does 
not normally show up in the kernel log:

# btrfs inspect dump-tree -b 31420155953152 /dev/sdh1
leaf 31420155953152 items 127 free space 3022 generation 1090179 owner 
EXTENT_TREE
leaf 31420155953152 flags 0x1(WRITTEN) backref revision 1
fs uuid b044297e-9527-4d22-bb66-c09206ad8aa7
chunk uuid 943d34f6-586f-414f-91a0-67b3f04e2feb
         item 0 key (31420152774656 METADATA_ITEM 0) itemoff 16007 
itemsize 276
                 refs 28 gen 1073175 flags TREE_BLOCK
...

I also ran btrfs check while the filesystem was unmounted. This first 
discovered the two transid failures also found by scrub, and then 
continued to find a lot more errors, like reference count and bytenr 
mismatches. Since the filesystem appears to operate normally and scrub 
did not find those errors, could this just be blocks which are no longer 
part of the filesystem tree, possibly not even referenced by anything?

Is this situation something btrfs check can fix? Is it possible to only 
let it fix the most problematic transid error and ignore everything 
else? Could manually patching the transid value help btrfs clean things up?

Most of the data on the filesystem is backup data, or can be backed up 
elsewhere, so losing some files would not be the end of the world, as 
long as damaged files can be identified and there is no silent data 
corruption.

Best regards,

Ivo


