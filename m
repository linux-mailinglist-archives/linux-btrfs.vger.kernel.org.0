Return-Path: <linux-btrfs+bounces-12050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E578A548B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2EE7A7FC6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66120371F;
	Thu,  6 Mar 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BMrbUAy9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202E4202984
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259031; cv=fail; b=PARao0rURnPBDnLJOGa73c2C68YHxQ1+b2N8Lq/IsZDxt7gDPYBIezuBbcxJn7RX6+f6v7FAriR85tS0NkDwvM2PyzXYJUHZFguWFR2Whm+AA91f1prA7KGmi610YXTbglhEuzsucdV0LWSwrzC1l6rZUCr0MbTjmjm5oFNpZoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259031; c=relaxed/simple;
	bh=5bvBdUqrJWrD7aMSovg4VN4uJs9YVBoP6zQOLF/YhFg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RworQZftjbq1PumF7HuvIwJ8pAo+jCDk1jtIlJtAvPkj1rEDx5ueBLwv3Ey7QBcCH8PiwnHDd3YrXz949SNJ1/p1APPpBGc/C7NjxquYmpbJFbeCn0S9LKYRJb6gigP2QOXcJdIy1S0Izo5SjE8ZkptV/cuLPTuorT+I7z6yFeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BMrbUAy9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 526B0VGx030688
	for <linux-btrfs@vger.kernel.org>; Thu, 6 Mar 2025 03:03:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=5bvBdUqrJWrD7aMSovg4VN4uJs9YVBoP6zQOLF/YhFg=; b=
	BMrbUAy9HQRZjRH+Ds3fmA5qzSCAXIhtxiay01au+lFRY5m6y1+DtVN1oXUoqR8l
	EPswEto7bdNwgS8xKAyW/8ksYgNdI14xoTi1vqrI3W4XlYVHgvbd0SvQJfHXqSo8
	i6SGysFihEPXi9HkfWeXMHX/4ZprBNG5fXLWMcIrsiSYD5L5mgd1Cscc5nw6aAJw
	hjr2JfUqdRxcJXidW/3Mam6eL3uSwaMKwkjMxM6n6YeqPt3JCP1qsC9wOUtxkf5y
	OPNRx/280NldKhoPQR4zgZlHIVA18JlvA2pELfU1JlVzgm5c82WW969Ig/FufRw9
	lYkH5l+70AoZ0jhbAM4aiw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by m0001303.ppops.net (PPS) with ESMTPS id 457aes00t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 03:03:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfyc1+aIgCzm+gQssw7GULys5ea1GgGVeo3IwwHOnNNjms6p3vMHIa6Y4KzEl0GQ7Oyj8klOQY12AFu094FrvEVh9S9EWPyXDgqxx67K3femrxIInMImImVbd8cXNotztpzFRg/R4AH7I9FLaYnWLmkZAXWpgwQfQKfA2ByPGyWraj1N75YGIGnPDmmbjh9Nio4B6DYirn0Ki0gE9xeQAa79dJLHT1mFwzCb3UsLvuUPmVKGxdqC0j5XLQMYojxp1SHGYKJVa9/QHqvMGIcO0lTWwaaq08ZaIemh7H49NwxuqtlVn2CM2mcqIeY2TQjxJdQiuJlHsF2EHIJgFHM0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bvBdUqrJWrD7aMSovg4VN4uJs9YVBoP6zQOLF/YhFg=;
 b=KZHmLvcLP25O8IdmZERfaAxzbBBuuriNr3Y7IsqFCFYA2AuTGZ4judPQTL8go/nvib5XiozCPrUKAf/VVxnIW5IP363bPeERAcJdOUTYinocY3lze5hw+SoyiKvHlSOTmcemyUPfqBnk0RWeluNR2JdQ1gmQ6VYD/21rVB3pCnikAXW8Q45fpGX4Xvw/6GdZQPJx/sjpBgXpkmCogUXxPCXd9cUciVyCvoUJtQmK+Y92c36T+8uuhgT/hHKqBxRv+zSdwOju/RghsqQZbh3Uvl+miyvvQnvjnrEUX9nizWM0V5A48exIp6TXfN0hwmUb1TVQgCHZ5MHk5/rCKQ7c3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH7PR15MB6462.namprd15.prod.outlook.com (2603:10b6:510:30b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 11:03:46 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:03:46 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
Thread-Topic: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
Thread-Index: AQHbjobNM7sHZpw7+EOO7v0buPx9jLNl8c2A
Date: Thu, 6 Mar 2025 11:03:46 +0000
Message-ID: <10586e9f-89d7-4d40-b1a0-027c10b5ce97@meta.com>
References: <20250306105900.1961011-1-maharmstone@fb.com>
In-Reply-To: <20250306105900.1961011-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH7PR15MB6462:EE_
x-ms-office365-filtering-correlation-id: e78729ea-7b39-4f0a-dddc-08dd5c9e90f7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWZZNmZ1SXUrLzdsYlNLVldFUWpXbXYwTVdQV0hiSUZ0QUh4SENZcTY3T3E4?=
 =?utf-8?B?aUkwS3NEWnhHR0o1MkZBcEtuLzhiK3hjVk5HbFcrUmplbXZkMDlseUgvZ1Iy?=
 =?utf-8?B?c3pXTlVJSkRoazV4aUlMN1RVU1JheTZ3MXBkNHRRdlplSHJmMm5YclpZMTVG?=
 =?utf-8?B?RXRLY3Q1U2dpWFgwczV2R21RUWxOTDN5a2RadGs4MmhpSXpvRzVTMEhHd2Vl?=
 =?utf-8?B?SGJyekN4OVpWaVhwR2xTQnRXeUN4NXdmQVZJMjJHSFFnUlRNNGlpUmVxcmFQ?=
 =?utf-8?B?bEo3R2g2ejRSKy9HTkFFalY3dTZ2aGtHS01DL2laSHYzRmpIUW1jdWhHQnkw?=
 =?utf-8?B?TlF2c1FqQjZ4OVo3eWVaWGhsNEo3VjJUOGYzQ2FFdGJlaC92TUIwK2xiUGlW?=
 =?utf-8?B?bS93QUtiUFp5cHlvbThjREtYb1ExQkZCajUwTVJ1YnhBZFB4TDFJRlVqWTZT?=
 =?utf-8?B?MXBPQVFqdGZXVWIxcmZoLzFjd0NBcE1zakcvQnY5QW1UYkxDYVMrS0JIbjUy?=
 =?utf-8?B?OHd0bVVNREZxQU12NmI2WEtpNGVkelM1U0dXRk9uZnZCT2FNcWNIZzI0aFAr?=
 =?utf-8?B?WVd3VGNYUjdsLzRJL1A3OWNpdTVJS1FQaFp0YmZkOE00cmR1WVRTU3RpSHdY?=
 =?utf-8?B?MmJsZWdrK3ozdWNPa1Btc3dLcXFKd1ZmQW5sY2JxWTIxaUFPWkg2VUxMUWVD?=
 =?utf-8?B?a0FOVElrclE5QzgrMFR2QytibDlEMHpuWkdXSG1nTDB3ekh3bXUwdmsvMUxZ?=
 =?utf-8?B?TjRYZnl0cHEvN0l4MVU3bHR0YXFRM2pvRE5td3NUS3VNSVlHUXBDZzU5WVJH?=
 =?utf-8?B?emdmdVA5TVRXbEtrL0VaMTlHa0FGdG9XTGVqNEtNSnU0N1NnckZOWTFnaExr?=
 =?utf-8?B?SVg5MUJsd0N6NFBCVCtYNHEyU2w5VFdjdXRKOXRuUUhHcHNHYmNtWnl5azRQ?=
 =?utf-8?B?T1dTbU5CZUNIRUYySjRJVU4zUWNsTFVNTUVJaHpqTmFEdWVHUkpQN2c3Qi80?=
 =?utf-8?B?Qlo5TkFSTW1BYnI5QnNZeGtsbWxPbFVFNElaaE9Sait5S0dCTWJvTGR4VlJ5?=
 =?utf-8?B?MEtoVGVoVW04NGQzMDZiMXdRbi9UZXBVdnNnaXp6ajl0V0NGeFQxd3UyU2F2?=
 =?utf-8?B?WWwzcXVlaUJFTUZ3c3JDT052WjNMYVpNRmVZTDVQaXZCM2FOb0VjQ1U1OVlv?=
 =?utf-8?B?ZWlMQ1kvZFFaSVJLWkt5eGZCbVJxRFdob09kYWZIN1lmMDBUYlFzTGVBK0JO?=
 =?utf-8?B?blZHSjZBZTFNcXFlYUg5MTA2dXBNNkRJWURJUVpQUGV1bm9RMmY5SFkzU25p?=
 =?utf-8?B?TkRTaXVCZE5JVGpIT1hxZVpId0h4TWU1bUVPOXlqcTZHTkdzcXFJbTlnNTJz?=
 =?utf-8?B?bFNlRjZDSm9HU0tqcStpamFxdVFmRWdxckhGeS9OTXhuQmxia2pybUZhZWZE?=
 =?utf-8?B?MXQyN2JScWcyNTlYSWQxYm1HOGpVdXFsR0xpUkxBYmxQVWxEdmVtak1OU2Ru?=
 =?utf-8?B?aVZBbjBGUFdDZk1KcHFiY28wemh0VVhZRVVMRm9VdnQ2WHdDSHd2Wi9DamF6?=
 =?utf-8?B?cGk4Y0lZWTN0bWFXdi9pZ1V5Tld1MkU4NGhHUnRlSXZtdFhRcExLeitvTnVr?=
 =?utf-8?B?Z1hKNlpRUHRtcFpOS0p6eGxTUjg5QVNRbGFSTEJiaFpJQ012Y25vZzk5KzJ0?=
 =?utf-8?B?dlJ0SDNoeW01Y1lxQ3pGZkJDZjdQWk1SM0YrcGRWRnY3WDQyalhsZ0wzMHkr?=
 =?utf-8?B?cGJmemc3aVNGSVNoQ0FhVXZ3Y2ZvbUoxei9ibFJmK2lneS9MTC91MTBLcXJB?=
 =?utf-8?B?a295VFVERGZGclQ5YmxDSEJySWdIUGIrRFIxQWVaRm9pYWIwRkltQVo5Tlgx?=
 =?utf-8?B?N29CaU1CQjBUeFdmZXdlLy9ORmVkbURlNXhkdjA1YW95MmFYRmRsZDdnMWxo?=
 =?utf-8?Q?mAoJYMgXEifDmQ3p4Wnm7CJ/jDrNk4wc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEdpWFRwa0tvdTNLZDIzbHNEcm1TNDR1VlVNaUIrWUNzZDIvc1cyb0QwR2lY?=
 =?utf-8?B?cW5QT05hZFdXL3V3UlhBeWNKVFZpczcyVVpJTExvbWVvaVp2Y042ZWQwLzVZ?=
 =?utf-8?B?NTh1Nm0zRTdRNEJQS2ZkZnF5TnU0ZSs0L1NBQngweTYza1VyS05UMEhCaktm?=
 =?utf-8?B?amk1ZGpqdC9CM0FKRjUzSUJzWkJnL01FcVZrQ0RndGxQTk5HMk1pWnlmN3Qw?=
 =?utf-8?B?aThib2RqVjVLVlZxWkVFcUJMZzFvS1MycTBwcEFRVjRrM21rNzlJM0V3Um03?=
 =?utf-8?B?M1M1NkV6TXpUV005aHUrSkVxN05GZGJxZ1dEWHRXelZoRlhzdzNwZXZkN0RS?=
 =?utf-8?B?VUFqMTk3WU8zd3VYOTZTVXYvcUZjYUFHOWpaZ1ZWaXpRV01rNXVjMldFeCtY?=
 =?utf-8?B?WDA0YTJTWUhLTExXbGJxZGZTNUZ0YUYvQ0FkUVFRMU9nNXYxQjJ3WU9RNUtk?=
 =?utf-8?B?ZmpOVXc1NnBtbmNkZkk4UG1Nbk5zU0IxMGtCOUpvZU15d2JrYnhVaEJ4QU4v?=
 =?utf-8?B?RHptVUlONVlsOHNLWXpnV1J4QmxBVXNSOW9hb3hVUlA4MXFLRmhrOHlrMTQz?=
 =?utf-8?B?TkZrQldoVkdaZ1FZcVRrTFpIRjlIWk5RMXJkR1ZwSmUxUTYxZXBqYndpMXNk?=
 =?utf-8?B?RGI0WWpBQU9EY3lLeXYyN3QvVXQ2TDRqN3MzTURPU255aVBrUFdRS3dvKzZO?=
 =?utf-8?B?SFgyNktpbEtZQnUzVUhEQUVFZHZ0Skc2MzkrTTJtZzFyK2VkZktJRUFUMmhW?=
 =?utf-8?B?MVZTajFmNXg0RHBIOGlLMVdtaGV4UmJYRlhnWlZzU09ld2hQakZCSEN1TFNT?=
 =?utf-8?B?dWdQWGNvR1p3c0ZhQ1hnbGduVmNDL01aQzBuazQ4cjE1NTJzcW9PSlB6OUI4?=
 =?utf-8?B?WWIyVlYwWUVJSVJZTzFGK3oySlNpUWc1OGlZbXV3eXNqYzNqemRodTNQak1Q?=
 =?utf-8?B?bnlReVIxNXNKUnBycVJLV0ozRW5Za3lyemhwSlYycSs0OFNjOVFOSHQrRDBZ?=
 =?utf-8?B?Sm80Ny96eURtK1lnRjNsODlYZXM4U1FYeTdlRDBLMW1hWGZPU3hjRnRoUmN2?=
 =?utf-8?B?M21hTXJBdXBwRldYL2tPTXdMYUo2YjNVWXdFR1BaQjNnU1IyZUVwYkxBdG9l?=
 =?utf-8?B?OWVsMEg5ekt2NndCQkVGQklRUlhsL2pGQ3oraVhxK1NvVlJ0b0Z0MFhxWnFu?=
 =?utf-8?B?L0tlSkp0c3lyUGYrVzY1NHBDYXBsQndiRXo1SmlNSlB6MzJaOWY2dE1LZVJr?=
 =?utf-8?B?VXBrWlg4V2pISHliVlk2YmV0TG9LNEQ3QjFFamEwTFZDR0pWalFES2xqdWpF?=
 =?utf-8?B?OTZ0azBQOHNHbVozc0FIbXNHZ0YzcnZBcmNtTVJ6dENGUHl5NDZRWm9KSW9G?=
 =?utf-8?B?TVBoZVZ4ekQzTUgybldQK1VRcWZqa3dCMk5yUVA3REFVUndMdVhPdW50dGpJ?=
 =?utf-8?B?MFc2THVxQ1cxZUREMUh1RUpWd3lOQUNibk00SUNVZ0FmSHcyRXIzUVZ5UmZp?=
 =?utf-8?B?WHQ0ZC9pME9EU1NwQjhqNW1VZTJNNUNXSlZPa2hJUWZRMEtvMk1zc1cxVFBu?=
 =?utf-8?B?dnhUekt4YkJmMDZldm5GdlUyOXZOQUt2bDRXNGN0UzhHUmt1a1lTeGtMbEQx?=
 =?utf-8?B?Qmk4cUNCYmMveTEwdm9rRzE1V2JXS0Q4bDNZcVBXVlZKQldvNldCWHJCWXQx?=
 =?utf-8?B?WWFTaHlpeXZPaVBaSjg4QkZscCtQbnVFZVFqV01qcm4weTF5aFBBTzc1eEV5?=
 =?utf-8?B?Um1ndlA4OVMwWTZmVFFlcGhVTmIrUGttOUhtMEdKQ1BpeENMTWJEU1IzV3FP?=
 =?utf-8?B?YXZBRUF6Skc2anY4Z2xBcTZ2dWovUm14NmNMK1diTXJrcHV0VnJpY0ZVb3VI?=
 =?utf-8?B?OHBhb3FQd2tzWmFuZHFERXpQOFFtRmJZNXJ4UkxxT3RuakpsRGtBV3BWb0ZJ?=
 =?utf-8?B?eUFraUJZQS91SXAvdVN4Tkh6eWNleUtnc1pxOThkOXRNK1J4MlpINHpKNmFL?=
 =?utf-8?B?ZWZraDdBZEpRaUt1UEJIcTBiajFaVkNHRGRTeGduQ1FlbGlpQnFCbVJPK3lr?=
 =?utf-8?B?eDgvaDh5VlhJR3pQNS9nc0cxTWl2ZUgwZlJZdnFKQi94eDdjSXRla3dGeW8w?=
 =?utf-8?B?WG9GZmRPQTBGYU1xRmd5U1lTSWxaSFR1YmgzNzBsczQvajVUbkx1S1d2b2lG?=
 =?utf-8?Q?+UPsVFmTnId/3viXTXJ0c5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658E3F381FE1FE41846CF8EEE2BE5CA2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78729ea-7b39-4f0a-dddc-08dd5c9e90f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 11:03:46.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGGy2Ue+DOLtevkcGVKJBzvZZSMguADjuEQ0+safQv/Ky6fq0yziDJ9xTyCz3OEjDQ0xwGktW1Ea5Q5W+FoAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6462
X-Proofpoint-ORIG-GUID: 65jB2oc8EqOvKc09JZ56cu6ZGOZSJKHF
X-Proofpoint-GUID: 65jB2oc8EqOvKc09JZ56cu6ZGOZSJKHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

VGhlIGNvbnRleHQgdG8gdGhpcyBpcyB0aGF0IEknbSBmZWQgdXAgb2Ygc2VlaW5nICI8b3B0aW1p
emVkIG91dD4iIGluIA0KR0RCLCBhbmQgYW0gdHJ5aW5nIHRvIGdldCB0aGUga2VybmVsIHRvIGNv
bXBpbGUgd2l0aCAtTzAgZm9yIGRldmVsb3BtZW50IA0KcHVycG9zZXMuDQoNClRoZXJlJ3Mgc3Rp
bGwgYSBjb3VwbGUgb2YgaXNzdWVzIGVsc2V3aGVyZSBmb3IgdGhpcyB0byBiZSBwb3NzaWJsZSwg
YnV0IA0KdGhpcyB3YXMgb25lIG9mIHRoZSBwcm9ibGVtcyBJIHJhbiBpbnRvLg0KDQpNYXJrDQoN
Ck9uIDYvMy8yNSAxMDo1OCwgTWFyayBIYXJtc3RvbmUgd3JvdGU6DQo+IFRoZSBpbmxpbmUgZnVu
Y3Rpb24gYnRyZnNfaXNfdGVzdGluZygpIGlzIGhhcmRjb2RlZCB0byByZXR1cm4gMCBpZg0KPiBD
T05GSUdfQlRSRlNfRlNfUlVOX1NBTklUWV9URVNUUyBpcyBub3Qgc2V0LiBDdXJyZW50bHkgd2Un
cmUgcmVseWluZyBvbg0KPiB0aGUgY29tcGlsZXIgb3B0aW1pemluZyBvdXQgdGhlIGNhbGwgdG8g
YWxsb2NfdGVzdF9leHRlbnRfYnVmZmVyKCkgaW4NCj4gYnRyZnNfZmluZF9jcmVhdGVfdHJlZV9i
bG9jaygpLCBhcyBpdCdzIG5vdCBiZWVuIGRlZmluZWQgKGl0J3MgYmVoaW5kIGFuDQo+ICAgI2lm
ZGVmKS4NCj4gDQo+IEFkZCBhIHN0dWIgdmVyc2lvbiBvZiBhbGxvY190ZXN0X2V4dGVudF9idWZm
ZXIoKSB0byBhdm9pZCBsaW5rZXIgZXJyb3JzDQo+IG9uIG5vbi1zdGFuZGFyZCBvcHRpbWl6YXRp
b24gbGV2ZWxzLiBUaGlzIHByb2JsZW0gd2FzIHNlZW4gb24gR0NDIDE0DQo+IHdpdGggLU8wLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXJtc3RvbmUgPG1haGFybXN0b25lQGZiLmNvbT4N
Cj4gLS0tDQo+ICAgZnMvYnRyZnMvZXh0ZW50X2lvLmMgfCAxMCArKysrKysrKy0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy9leHRlbnRfaW8uYyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jDQo+IGlu
ZGV4IGZhZDQyZGExYTZiYS4uMDMzMjBmOTUzODE3IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9l
eHRlbnRfaW8uYw0KPiArKysgYi9mcy9idHJmcy9leHRlbnRfaW8uYw0KPiBAQCAtMjk4NCwxMCAr
Mjk4NCwxMCBAQCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZmluZF9leHRlbnRfYnVmZmVyKHN0cnVj
dCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPiAgIAlyZXR1cm4gZWI7DQo+ICAgfQ0KPiAgIA0K
PiAtI2lmZGVmIENPTkZJR19CVFJGU19GU19SVU5fU0FOSVRZX1RFU1RTDQo+ICAgc3RydWN0IGV4
dGVudF9idWZmZXIgKmFsbG9jX3Rlc3RfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgYnRyZnNfZnNfaW5m
byAqZnNfaW5mbywNCj4gICAJCQkJCXU2NCBzdGFydCkNCj4gICB7DQo+ICsjaWZkZWYgQ09ORklH
X0JUUkZTX0ZTX1JVTl9TQU5JVFlfVEVTVFMNCj4gICAJc3RydWN0IGV4dGVudF9idWZmZXIgKmVi
LCAqZXhpc3RzID0gTlVMTDsNCj4gICAJaW50IHJldDsNCj4gICANCj4gQEAgLTMwMjMsOCArMzAy
MywxNCBAQCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqYWxsb2NfdGVzdF9leHRlbnRfYnVmZmVyKHN0
cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPiAgIGZyZWVfZWI6DQo+ICAgCWJ0cmZzX3Jl
bGVhc2VfZXh0ZW50X2J1ZmZlcihlYik7DQo+ICAgCXJldHVybiBleGlzdHM7DQo+IC19DQo+ICsj
ZWxzZQ0KPiArCS8qDQo+ICsJICogc3R1YiB0byBhdm9pZCBsaW5rZXIgZXJyb3Igd2hlbiBjb21w
aWxlZCB3aXRoIG9wdGltaXphdGlvbnMNCj4gKwkgKiB0dXJuZWQgb2ZmDQo+ICsJICovDQo+ICsJ
cmV0dXJuIE5VTEw7DQo+ICAgI2VuZGlmDQo+ICt9DQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBl
eHRlbnRfYnVmZmVyICpncmFiX2V4dGVudF9idWZmZXIoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8sDQo+ICAgCQkJCQkJc3RydWN0IGZvbGlvICpmb2xpbykNCg0K

