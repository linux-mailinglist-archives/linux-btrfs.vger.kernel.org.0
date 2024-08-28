Return-Path: <linux-btrfs+bounces-7605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852EC9622C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1901C2441B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725515ECC5;
	Wed, 28 Aug 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JE941T6n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2035.outbound.protection.outlook.com [40.92.89.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C315B55D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835013; cv=fail; b=SqttZpAexp6Elef+1cJ40vVh3EPU8ErTiHbYkv5tmnucHDUUP3Lutk511GoKVqwDgLW5DNrh/yvZiD4sREZvkKqrG/Jk3rCGa4TJIUeM4CUx5+a3YL18aMN7gi0gsWMZtKeLNrzCbMn7FtthAWMF7Zyn2udNLF73BwYCW3eCQ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835013; c=relaxed/simple;
	bh=4TlA6wryOZid6IT2GaNDfSMtHnFY6a5s4sXivlq9t0w=;
	h=Content-Type:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:MIME-Version; b=YBmGmkuzNL+LQJaf9f0VpZhuW0YBnvP2GDQ8oKJfja9b/1d7nDxfKDwpb+MGVKhbxv0lMJt42a2vKwCyCTB9LTV18rdVJiewkQpi5jHqe7DLxnxygwD9LYAwaBgKMgGQNmRovgidO8bPAa0F/6p6PbtEVwMecwV6Gvuz88gxLLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JE941T6n; arc=fail smtp.client-ip=40.92.89.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR1FaSWe+WUxSdHDlL8omtEbnFSYhDJhIJAHPD2H19UHJiXFYDhgFwC3JKCuo6+cSF/SNzOz1ZsjCYT7dRNC12J6hKDkbMq0nRLuqrkEv4HKlMDOGD4Hat/+DoFhPN7fLkM0nGnb9n6SVIEQY6RkInr1at0Xvm8qUpjNswmnhaLfEL/KUSEqoxq5cfnRlMZo/1xM+kuOArOtiHa+Vm5881DrEi6Bxwu3qIFKEtRjGHQEeq0c5TxMIAAIGwj5ICiHmn4m6BVCY7+8n7CEGwHCpXnjZ8OvAoPRmSBUJuadf3KWroVWkgQU0CaujJl82P9t9aKNhH9xJe7cFy2Wvj0dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KzI1nIIncoL/QM2GXIw42+J8rZ++PS/uftXzL/xnxU=;
 b=yqE1v5cN3uKC9Pw4zJw4c4drSupvAZ0+4rz2IzzvQXcUmdv2ITsjBJVaL6LHhkiWC26j/wClVllnZTUWsCXsJ1RUAXmIeobUo/vRY9x87spUOfZx+HADwWxwar3DU4Bbz9LlITjZaOQ0G8MWHHWnKKAyWJsotAI3kanYvDadUi3VWfVOR77Oea38HJU+9ak9VU7Wi9Jf6h+tZwjJvAhr/Qy0NpNRWpw2tSsDGmDjKKiIRwUJkLcee2xkwh/CQmRQ99713pkyVQ1eBXtwAQkaREfRUjsqKG9akjepQGC7W0PYBguxLq+yoCr8yr29ppKDjhCWmMvpuHKVy/DlJ/sOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KzI1nIIncoL/QM2GXIw42+J8rZ++PS/uftXzL/xnxU=;
 b=JE941T6nPXqcJxsWdrlWusJtI7V29qmSjXRVWCuy4p8PePAiNZH6fx17s7wNAnXKM/xGceNWsZ5dH7ig3ouY6dzJBg1UPSewPHTGdXU7UNWNDw4k0R7RZvWVeqTzUPyOce2NTfbNOyOJwDOV5sEAiQAyQXHzG0VqaqRSmTr90l88b/8ZSz7XcefAtjejoxRqCwP2ok09hvA1KLUVYicwmdOSzm/QsbMlmnPgyS7o4nB7F2aH5eOsE/oZ6N0E6SbWCOgZ+FjXrAv/GNl1CWtiEEva/bL8fqoWLIXU4C0tD2dAhV2dgg/JH8J0GBh9rwtsiGY7KLbsloAMh3HfDOG78g==
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:54b::7)
 by AM8P250MB0139.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:322::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 08:49:17 +0000
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61]) by AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 08:49:17 +0000
Content-Type: multipart/mixed; boundary="------------uuv0d6EPQMf8dTMEt6jmxOrP"
Message-ID:
 <AS8P250MB0886524C03F0508E132BCF7E8F952@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Date: Wed, 28 Aug 2024 10:49:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
 <bc8701ab-0054-48c7-88d9-6fd9e856cde7@gmx.com>
 <c29529ca-e6b5-4979-a25a-b254a4d800d0@gmx.com>
Content-Language: en-US
From: Pieter P <pieter.p.dev@outlook.com>
In-Reply-To: <c29529ca-e6b5-4979-a25a-b254a4d800d0@gmx.com>
X-TMN: [gik2/vV0MGU2GusvqEBVnhDvGKRFz1UM]
X-ClientProxiedBy: PR1P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::11) To AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:54b::7)
X-Microsoft-Original-Message-ID:
 <fb6b5f95-d66e-41a7-9170-e7128e7691fc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0886:EE_|AM8P250MB0139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0a5bed-6898-4574-c986-08dcc73e4d28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099012|19110799003|8060799006|461199028|15080799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	6euZV5r9TNHNQ0rv3Aw0apQVCO36EMEn0rqzHO+j+55DdIPDA4u5+A2HqpeNs7x/q9++hYU1y0hCIRZyXCEgbMp0sziSXVNkf/8in6IGulBabMJytahsMvdWcHtwPhcz02t1bw+MfGExzgVBhmDuCcMRjhmQlurTQ0v8vsanQtBV0bXMUhdWBjZzAJ6+DSNuYKqsxFs0X6yRM5becy4eBBHzKm6veuMPfdHTXdlpwXMJcsjChY32AM0cnYD7MkLWVdiVrbPcUpBJAQ05AYp4ygUihsntTA//RNdDmDj4PTbsJmmaPpFb15F8Ecmv6v0jqUTSfKS90MaVu5qPW2K+ZfJGMFFGBIUVFIH+NnAGczAIfp+JGl5Gr3uUrrImOR+Sx+6q9JfBDGmWfusKdbdDJmnN2CPVeMnFYBYsI3tQzjgK6gwLVECQcCUGveqbM2nBlSQuktwSie16CO6qE8kdTje3jDPErzVxDoJProgMVbkQRehFMAHNQeqLkOpA5ih5Jb0PNOl/Gr7LxIirPUKuF92j0pr3Ik1KWkMjtVF7ltQgq1BLAZqeOT2MLy+gg5MVEp683q6JU5Gzxb8K9Z5LTt0rR6USLdZv2dOI3JQkMiM1k3MGKC8uRds4OYaGrVRS5PlqZa6i36zCStJCL62PVbnYQtVgq5m9trLKQtIMgkvFhCJpUrW8N385abktVn4Z1uYpLKLbv4Rvm9Q27nU8bFIyRTBfKrWpdoZ6lpx9h9a4f986uqnDVJ0jmbiYj3dg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTkrd1dYMVM2Rk5TNVV5elhtMkdVK3dBZk9Gc01aWUtrZ3VlY05adStmQ0tL?=
 =?utf-8?B?WXZ4MzhzU2t6V0hYQnVmZUJVazdUWWpyem53cE9UTGRISG0yR25XM0NDVkNo?=
 =?utf-8?B?L3lsWGxjY1JvWWJqcG1MdU5DY0JmenRwSWg1RGhkU0pUbkNzblFvSlFVc05Y?=
 =?utf-8?B?YmFzZEVsWERxeWZSQi9hT0lTdHpJR0Iva1RqQXBvanJ5OHB4RU9nRlUvU25T?=
 =?utf-8?B?d2djeTNRWHpkZTdqOXFEUkJRODhGUUhvM3pRRUdIY3hnbUZvUG0zd2VhMTdJ?=
 =?utf-8?B?eGgxSE8zRnJUKzJORElCU28zZFpMMG1uMXNEcHRaeU1VOEEzaW03ZUM4VzA0?=
 =?utf-8?B?SWhoZ0MvY1Q2NzVleHhqYlhNVnFhczJWcWZqbFl5cCtSZWwrWnFiZk1URXNs?=
 =?utf-8?B?anNPb3dyZzlob1B5Vlk4d1lHWlI3QXJiNlJsdXEwSDd3WXB3cG1IMVd4V2Rt?=
 =?utf-8?B?R0dwRXhMSk8rbHdac3M5cmFNVHdzUmJMamVqSWsxZjNVNW5yb1RNQWdqeVhS?=
 =?utf-8?B?eWxZaUY5WnNPbW1ZV3hmMEtxbyttMGl1SzFuRUlWang5b3pXVjEzNkNyTjVy?=
 =?utf-8?B?Qi9TNjRXODVkc0tSZGlaYXdLM3pwZ2hRYURVb0VxWnpKVGQraGtIRVRRMTlT?=
 =?utf-8?B?M3padlREY2ZYdHRKMlpaOWR4anBpVDZlM2FrMWpBbk5kWkkwREd5LzF3N0xw?=
 =?utf-8?B?UmRFOEpPLzJnZTFhOVRBUVZiMTdNandUUW10UEpZQU4wK0s2QnIrdU9lakkz?=
 =?utf-8?B?SFhHaVgvWG1OeXNCSWhhWTRaV1ZpdXQwKzg1b2FuMkY4MW5rRGpicmdaTUJ6?=
 =?utf-8?B?Y0loeGh0T1FnQy9DZkUxK2xUcWxFd0d0dk9xWVZtRkx4d2NGcXp1Y3kreUpG?=
 =?utf-8?B?VEgyQ3NKbkROZEg0b0RKa2I0cDI1SkVVWFJCWnRCUUR6LytraFNVNGJ6d2Ew?=
 =?utf-8?B?Q1U2S0pRdlM2OWR1ODFsNitoWFgxVUhQYjhyRDg0VTRpbXlhZFJDc2laREtX?=
 =?utf-8?B?cXhkUFM3WWYrU04zd1hKaXk1ajVIM1lqSTJaMEhmc25CVXI2dFJFTlh4NjI0?=
 =?utf-8?B?ZzlpVDNvWHBWeHUxVTh6ZTRzZUdjNDkycnVzMnBFY2E0VlVtQWdncWZFalhU?=
 =?utf-8?B?RktiUnUvb0ZmNGRGbHJmbnNTSFNWNE8ycmRZNUFrcCtEcWdyYlQ0a0w2VTFG?=
 =?utf-8?B?OG5QS1pHMDFoMU0wL2FaU2xRczlTc1hIVVYrUkJmcGl0RWVXRnBWck5WREJD?=
 =?utf-8?B?Ykl4WGcxbzIyWVQvQ2lab1RXNHBtMlVYWVZpKzg4VEFzQUhiMFkxYXJIc0FN?=
 =?utf-8?B?MWZvdzlJUk1SN0FtTXdtd2VSQXo5N2dqZDNSZmw2QkNhMHUyalpKYWkwUjgz?=
 =?utf-8?B?MGgzcS9JcWRMajBJR3dtZmxsM2ZKYkxGeUFDTGhsSG1EejNmRkV3WkJhYlF3?=
 =?utf-8?B?bTYyN3ROYm0wdUdyUm5lRXYwQU1WeWkrQzNqZjNTRGZURmgrdzM5Q2swMXdq?=
 =?utf-8?B?YWlGRU1sdC9LSGxZdkJoQ29yVno5VUtqVTlZK1AwSVFwdUYyRkE4Y2tVT1JF?=
 =?utf-8?B?eG0zRVhiNkVNbjRIZkMwdWY4dzI4Vis2aXRhWU5FcWlYZGNpbE9BME90SElL?=
 =?utf-8?B?RVZlTHdEdWFXMmp1MWM5bUhLWjdRZU1nLzFRV3VBQktiUDVQTWVXeGFTeDRa?=
 =?utf-8?Q?5vLxv1N9WkYR96F5cOTl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0a5bed-6898-4574-c986-08dcc73e4d28
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:17.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0139

--------------uuv0d6EPQMf8dTMEt6jmxOrP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, I really appreciate the help!

On 27/08/2024 11:33, Qu Wenruo wrote:
> And it's better to run "btrfs check --readonly" after a successful run
> (the successful should result no output), and paste the output of the
> btrfs-check.
>
> If there is something wrong, the program should output something and
> please paste it here.
btrfs_search_slot did not seem to like the combination of trans=NULL and 
cow=1, so I tried both btrfs_search_slot(NULL, root, &key, &path, 0, 0) 
and btrfs_search_slot(trans, root, &key, &path, 0, 1), and the latter 
fixed the issue (see attachment).

I no longer get any errors from btrfs check, and I've verified the 
contents of the file system against an older backup, all important data 
is still intact, and everything seems to be okay now.

Thank you very much for taking the time to help resolve this issue!
Pieter

--------------uuv0d6EPQMf8dTMEt6jmxOrP
Content-Type: text/plain; charset=UTF-8; name="btrfs-output-3.txt"
Content-Disposition: attachment; filename="btrfs-output-3.txt"
Content-Transfer-Encoding: base64

c3VkbyBnZGIgLS1hcmdzIC4vYnRyZnMtY29ycnVwdC1ibG9jayAtWCAvZGV2L21hcHBlci9sdWtz
LXh4eHh4CgpQcm9ncmFtIHJlY2VpdmVkIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50YXRpb24gZmF1
bHQuCjB4MDAwMDU1NTU1NTU2ZDI1MSBpbiBidHJmc19jb3dfYmxvY2sgKHRyYW5zPXRyYW5zQGVu
dHJ5PTB4MCwgcm9vdD1yb290QGVudHJ5PTB4NTU1NTU2MTIwOTIwLCBidWY9MHg1NTU1NTYxMjRj
ODAsIHBhcmVudD0weDAsIHBhcmVudF9zbG90PTAsIGNvd19yZXQ9Y293X3JldEBlbnRyeT0weDdm
ZmZmZmZmZGY3OCwgbmVzdD1CVFJGU19ORVNUSU5HX05PUk1BTCkgYXQga2VybmVsLXNoYXJlZC9j
dHJlZS5jOjY3NQo2NzUJCWlmICh0cmFucy0+dHJhbnNpZCAhPSByb290LT5mc19pbmZvLT5nZW5l
cmF0aW9uKSB7CihnZGIpIGJ0CiMwICAweDAwMDA1NTU1NTU1NmQyNTEgaW4gYnRyZnNfY293X2Js
b2NrICh0cmFucz10cmFuc0BlbnRyeT0weDAsIHJvb3Q9cm9vdEBlbnRyeT0weDU1NTU1NjEyMDky
MCwgYnVmPTB4NTU1NTU2MTI0YzgwLCBwYXJlbnQ9MHgwLCBwYXJlbnRfc2xvdD0wLCBjb3dfcmV0
PWNvd19yZXRAZW50cnk9MHg3ZmZmZmZmZmRmNzgsIG5lc3Q9QlRSRlNfTkVTVElOR19OT1JNQUwp
CiAgICBhdCBrZXJuZWwtc2hhcmVkL2N0cmVlLmM6Njc1CiMxICAweDAwMDA1NTU1NTU1NzAyZTMg
aW4gYnRyZnNfc2VhcmNoX3Nsb3QgKHRyYW5zPXRyYW5zQGVudHJ5PTB4MCwgcm9vdD1yb290QGVu
dHJ5PTB4NTU1NTU2MTIwOTIwLCBrZXk9a2V5QGVudHJ5PTB4N2ZmZmZmZmZlMTgwLCBwPXBAZW50
cnk9MHg3ZmZmZmZmZmUxYjAsIGluc19sZW49aW5zX2xlbkBlbnRyeT0wLCBjb3c9Y293QGVudHJ5
PTEpCiAgICBhdCBrZXJuZWwtc2hhcmVkL2N0cmVlLmM6MTMyNAojMiAgMHgwMDAwNTU1NTU1NTYz
ZmQzIGluIGRpcnR5X2ZpeCAoZnNfaW5mbz08b3B0aW1pemVkIG91dD4pIGF0IGJ0cmZzLWNvcnJ1
cHQtYmxvY2suYzoxMzM1CiMzICBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0
aW1pemVkIG91dD4pIGF0IGJ0cmZzLWNvcnJ1cHQtYmxvY2suYzoxNTI4CgojIEVkaXQgYnRyZnMt
Y29ycnVwdC1ibG9jay5jCjEzMzU6CXJldCA9IGJ0cmZzX3NlYXJjaF9zbG90KE5VTEwsIHJvb3Qs
ICZrZXksICZwYXRoLCAwLCAwKTsKCm1ha2UKc3VkbyBnZGIgLS1hcmdzIC4vYnRyZnMtY29ycnVw
dC1ibG9jayAtWCAvZGV2L21hcHBlci9sdWtzLXh4eHh4CmVjaG8gJD8KMAoKc3VkbyAuLi9idHJm
cy5zdGF0aWMgY2hlY2sgLS1yZWFkb25seSAvZGV2L21hcHBlci9sdWtzLXh4eHh4Ck9wZW5pbmcg
ZmlsZXN5c3RlbSB0byBjaGVjay4uLgpDaGVja2luZyBmaWxlc3lzdGVtIG9uIC9kZXYvbWFwcGVy
L2x1a3MteHh4eHgKVVVJRDogeHh4eHgKWzEvN10gY2hlY2tpbmcgcm9vdCBpdGVtcwpbMi83XSBj
aGVja2luZyBleHRlbnRzCnJlZiBtaXNtYXRjaCBvbiBbMjIxNjcxODMzNiA0MDk2XSBleHRlbnQg
aXRlbSAxLCBmb3VuZCAwCmRhdGEgZXh0ZW50WzIyMTY3MTgzMzYsIDQwOTZdIGJ5dGVuciBtaW1z
bWF0Y2gsIGV4dGVudCBpdGVtIGJ5dGVuciAyMjE2NzE4MzM2IGZpbGUgaXRlbSBieXRlbnIgMApk
YXRhIGV4dGVudFsyMjE2NzE4MzM2LCA0MDk2XSByZWZlcmVuY2VyIGNvdW50IG1pc21hdGNoIChy
b290IDI1NyBvd25lciA1MDA1ODc1MSBvZmZzZXQgMCkgd2FudGVkIDEgaGF2ZSAwCmJhY2twb2lu
dGVyIG1pc21hdGNoIG9uIFsyMjE2NzE4MzM2IDQwOTZdCm93bmVyIHJlZiBjaGVjayBmYWlsZWQg
WzIyMTY3MTgzMzYgNDA5Nl0KcmVmIG1pc21hdGNoIG9uIFs1NzY0NjA3NTQ1MjAxNDE4MjQgNDA5
Nl0gZXh0ZW50IGl0ZW0gMCwgZm91bmQgMQpkYXRhIGV4dGVudFs1NzY0NjA3NTQ1MjAxNDE4MjQs
IDQwOTZdIHJlZmVyZW5jZXIgY291bnQgbWlzbWF0Y2ggKHJvb3QgMjU3IG93bmVyIDUwMDU4NzUx
IG9mZnNldCAwKSB3YW50ZWQgMCBoYXZlIDEKYmFja3BvaW50ZXIgbWlzbWF0Y2ggb24gWzU3NjQ2
MDc1NDUyMDE0MTgyNCA0MDk2XQpFUlJPUjogZXJyb3JzIGZvdW5kIGluIGV4dGVudCBhbGxvY2F0
aW9uIHRyZWUgb3IgY2h1bmsgYWxsb2NhdGlvbgpbMy83XSBjaGVja2luZyBmcmVlIHNwYWNlIHRy
ZWUKWzQvN10gY2hlY2tpbmcgZnMgcm9vdHMKXkMKCiMgRWRpdCBidHJmcy1jb3JydXB0LWJsb2Nr
LmMKMTMzNToJcmV0ID0gYnRyZnNfc2VhcmNoX3Nsb3QodHJhbnMsIHJvb3QsICZrZXksICZwYXRo
LCAwLCAxKTsKCm1ha2UKc3VkbyBnZGIgLS1hcmdzIC4vYnRyZnMtY29ycnVwdC1ibG9jayAtWCAv
ZGV2L21hcHBlci9sdWtzLXh4eHh4CmVjaG8gJD8KMAoKc3VkbyAuLi9idHJmcy5zdGF0aWMgY2hl
Y2sgLS1yZWFkb25seSAvZGV2L21hcHBlci9sdWtzLXh4eHh4Ck9wZW5pbmcgZmlsZXN5c3RlbSB0
byBjaGVjay4uLgpDaGVja2luZyBmaWxlc3lzdGVtIG9uIC9kZXYvbWFwcGVyL2x1a3MteHh4eHgK
VVVJRDogeHh4eHgKWzEvN10gY2hlY2tpbmcgcm9vdCBpdGVtcwpbMi83XSBjaGVja2luZyBleHRl
bnRzClszLzddIGNoZWNraW5nIGZyZWUgc3BhY2UgdHJlZQpbNC83XSBjaGVja2luZyBmcyByb290
cwpbNS83XSBjaGVja2luZyBvbmx5IGNzdW1zIGl0ZW1zICh3aXRob3V0IHZlcmlmeWluZyBkYXRh
KQpbNi83XSBjaGVja2luZyByb290IHJlZnMKWzcvN10gY2hlY2tpbmcgcXVvdGEgZ3JvdXBzIHNr
aXBwZWQgKG5vdCBlbmFibGVkIG9uIHRoaXMgRlMpCmZvdW5kIDU5NzAzMTM1MDI3NyBieXRlcyB1
c2VkLCBubyBlcnJvciBmb3VuZAp0b3RhbCBjc3VtIGJ5dGVzOiA1NjM5Nzg4MjgKdG90YWwgdHJl
ZSBieXRlczogMTQ3Mzk4MDAwNjQKdG90YWwgZnMgdHJlZSBieXRlczogMTMwODgyMjczMjgKdG90
YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDkxMTkzMzQ0MApidHJlZSBzcGFjZSB3YXN0ZSBieXRlczog
MjUyNzcwOTAzNgpmaWxlIGRhdGEgYmxvY2tzIGFsbG9jYXRlZDogODE2ODEyNTM1ODA4CiByZWZl
cmVuY2VkIDEwNTUyOTA0OTA4ODAKCg==

--------------uuv0d6EPQMf8dTMEt6jmxOrP--

