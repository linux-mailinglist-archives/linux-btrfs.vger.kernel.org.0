Return-Path: <linux-btrfs+bounces-15195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E7AF1051
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE535218B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53124C060;
	Wed,  2 Jul 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G5fpQKbA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011039.outbound.protection.outlook.com [52.103.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA5248166
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449241; cv=fail; b=XrjpC1Chl8FFJpLngcZ1Y8FDH2WFjsK//o4eb/ieIP+JJ6JS0wyYmzCB0NIBUEVqsR/tebrDUwzjMholTjYKDJXZdSbgytjfmXUtjoBbBUQkX0c6xGsXjrDTJG9qwi8uPWvedsXL9NoSpcSNvYMB/3pWpuPZFa8Y/PrBoNOuHME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449241; c=relaxed/simple;
	bh=LtLVw8jU4ztIlFKazu7CXkvbV41vPKZIEbOf900UTEc=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=BNziRTiVI/5NoL6SjPCRiWzLyHMUlkT0Hfp2yYv5DKDe3ZHwMafdm5oTXmYQCqy9D2/5yfSTHFMeKnYVza/FPbUCNQsTXMT3OFde+590w5VFXe87ZZ/ZXPdsTw9QNxLavkYKaNt2Fq5OT1HhI0jYmmMq+KkYwfrLTO8O/f/SDgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G5fpQKbA; arc=fail smtp.client-ip=52.103.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7fKXDbjTgiYXrlzVsKazArtF1mVX7pnJkKyyklxzfvT+J8FWm5QSWxYpLMfvhLGNpZOVyI4CckblSF3lrkhRNxAnjUnmj4DE+0L5T0rhu+ujCC4uaQjmBoXTCs0zVyrehhsFVFuHzR+eAAEGjE9nyVmvPk14m+yVsRjmDSb7zU8Kgww0Nro861LFwMFKW54Ioo/HjQzISyqnNkdCg5TyUftw4j6yR/2GcooR33EzYuXbo1K1HTdKi73KlKzMJ1pow7rKgyPUFeeOzOtDL3IXY9RLp3S9wlenirvBBF6CDfBt2W4YsLQbC01xPNfaM3kgDsF8rk64MhhWIs6ny2A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChfXxSzii/MeAy3dpjv2AUDN//7Of4/YBO5h36E5uh8=;
 b=Km9qj/FHQs7/wVwEHnaiQu06DS8k3ODyZFywGmuTUEE7ttthDfnP2cidn+q1f7t6YCDxz8P+jnO0qroJFKis9byAugOypoE0b6rUL5nfhhCwwohkdW2GN4Paq9hjJ6SRIM8jxlhfD9DttYJj47cjwEtgHPN90NK1s5KDO8sbSbhoQSWQ2hOZ6exqUoC+5fO/LxCesZDVpnMhSRwiKaVLGM782yaH+SO/VhBYfrP3AHJi7mZ5GdyoHefmNWI/teCB2OKF16V9JhcafX0g3/cgn9d6eGut1jiI6KNgDPBAo24hkPyB5V3WMn131W0PgrCJfSMpYPUKT9KXwpj+Agbx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChfXxSzii/MeAy3dpjv2AUDN//7Of4/YBO5h36E5uh8=;
 b=G5fpQKbACbF1CtRsxdQqgRKjkfJqqQOR7FjM43ABlN8vMtMk7HNZfP3EXsVBtV84DZoeh9lAP1cqwokrZ/yqbvsOlMiWGD6tDYf6WSorgK2uASLCWf9BKvYBIoGhHPZWAOA943TYO709itNITbRIrwe3JuXFaKComSdAWP5v/UOlryJNhqCCFFZiJ18AeWtiXqfYZn02vZR6qeaZ7YQd3G9B4Z0lwaKMEKM64eF3tQVO17vG6Ul7i13rhKdCBGoFpvcQ7wUFpowa210O3AmHBKpOzA7VQeeE4ZUKxxVFYi6CFEkt9cESZ89vf4hzE8V+H/j9MPOjd1ybIcJVskaCNA==
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com (2603:1096:405:1fc::7)
 by TYYPR01MB13984.jpnprd01.prod.outlook.com (2603:1096:405:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 09:40:37 +0000
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45]) by TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:40:37 +0000
Message-ID:
 <TY4PR01MB13853B64BF6DB7BEA98170AE99240A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
Date: Wed, 2 Jul 2025 21:40:32 +1200
User-Agent: Betterbird (macOS/Silicon)
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Mio <mio-19@outlook.com>
Subject: multiple devices btrfs filesystem device detection on recent distro
 updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AK1P299CA0017.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:17::15) To TY4PR01MB13853.jpnprd01.prod.outlook.com
 (2603:1096:405:1fc::7)
X-Microsoft-Original-Message-ID:
 <fe0de044-d0f0-4156-85fb-781026ec8a95@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB13853:EE_|TYYPR01MB13984:EE_
X-MS-Office365-Filtering-Correlation-Id: 39847a92-3737-45fa-d510-08ddb94c7fe6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|6090799003|461199028|5072599009|1602099012|3412199025|40105399003|39105399003|51005399003|440099028|4302099013|10035399007|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDBjTEVjYk02NzVmanVEaTlwc3ZySGw5b053RWdTd2pNMXIzMlVIcnV5Zlpv?=
 =?utf-8?B?K3d0ZWJVaFhWVFpoaGZ4U0NyWDlGb2hKdk1wVHEvdUMvWmIwaG5IZVhXa2w3?=
 =?utf-8?B?YXBUSUJPZ2lqZmFZaVoyWGhFR25pRHpyWENhTFgya29rUXY4Z3pxVC9OTDZ4?=
 =?utf-8?B?SGxETjJMOWF6SE82QlJQUVdIc3JIajNHb01JYWZhUVE5MytDaTZJb0VST0dH?=
 =?utf-8?B?ZXlZYktoK0ljekltV3ZiWTRsT2hiRTNYSHpSWHdJUGVRcituOExpcURUa1hY?=
 =?utf-8?B?REJwQnFIZ1NpM205YzZHdHl1dHAxZ2cvbG5LcnJ3cVpWblhBd0VWNWUxbk1o?=
 =?utf-8?B?UTJ2S2M2eUtqamdKSmE4UHVWQmhpQ3NWcmorKzBkWDZhSTRqN2oweXhlTmM5?=
 =?utf-8?B?ZGFtWVczdFRwaTA1Qk0vYndPMGNHUlg5bU1jcFc5eWRwcXRwYkRvdE5lKzVT?=
 =?utf-8?B?NUZUT2VzbWEwcFNQbUhLaVJweXZ6T0JMTXJSb1RqV3JyVjRaRlJvQjFaYTJn?=
 =?utf-8?B?K01DbTFTbkJhMkRITS9YL3N4TDdqaCthTEFyb3lUTEVtazFjUXJ6RGxEcTEr?=
 =?utf-8?B?OXo5TmF3VE5USXFsc2krblN2VEQ3VlovQlVCbFEyeEFiOUV6dm81QS80U1U3?=
 =?utf-8?B?VHY4UGFvZ0hQc0tiSDBTMnk4Q2N5UTB0cUxVUzJSeHc0c0xTUngremQvZ3FS?=
 =?utf-8?B?M1QzNExwdXNESGdhdmdjZVV0cWxQMElrVDZlS0VqV29pSU84L3VnZFZJYURw?=
 =?utf-8?B?VE5OTnMwT0lSSGNZYjgzYVJZK2Zick5icFFMRmxHYUFMRVpqVVJCUmZoTk1S?=
 =?utf-8?B?aUdiKy9WZmJubng5RzZ1Ujk4UmpkMVJURG1iVkFjM3hSTk1Uc2R3Ym8zWnZV?=
 =?utf-8?B?dFoxMzFJZWczR2ZwWDd0YWtYLzQ4YWtERnYyZnVMK1ZrTUcydFlpMzhMeWdE?=
 =?utf-8?B?ZSt3amRWWmtYSXdybEYxOXA0Zmt5c3JBSXdrK0toQVF0RnNmajdBRjYzdm4z?=
 =?utf-8?B?OVVocE5RNUVNNG9UbGZuejFaWmx4VWFHT3lTWUNWTldoUURHYXBIYlYyTFlH?=
 =?utf-8?B?dGtWT0V4amc3dEdyNCtSWkdQUjBZcmphTkxFUm1ENDhPUHB1cVZXSlZZWTVp?=
 =?utf-8?B?NE94eEVIdmVsdWxIbldYVkpsR0hIbUtpQVZaalE5Z2dBL1JPWGZQVHdOU2Fr?=
 =?utf-8?B?elQzM1VwVC9KdGdrdCtzTUtoQ3Avd3ZzeUsrMmNOc0V1SVJWVUxpV1R5L1Er?=
 =?utf-8?B?VFdtTFhPK0tDaEVZOXkrNnVEeTNJT3djVGt1cW9RcjFCZ2paMTh6aVN6V1hJ?=
 =?utf-8?B?ckZVWVlQaE11WDcrRGxUNHJzVUVXTjhFWkxQMzBCYjNWTlE3WjYrbzFHNUhP?=
 =?utf-8?B?blBhYUVBM1ZFbEVpTXAvZmNjV3I1SGI0UWVkc3AxUXNVZzUvKzNrWjNYUllJ?=
 =?utf-8?B?emllM2lUMzNxNXNvbTJibC9JcUEyRzdGUytNQ0ZwTFJKTFkvSWo4eGE4NjdG?=
 =?utf-8?B?NmVyUXZpeDZlWmlBRU1QQlB3NjhTdmhsTDBuVURqbUJPcGJqZjhRMFV4OVIy?=
 =?utf-8?B?SktZQzhOTXpkdjF3RkZqMWxnWXE5NXMyYkxQcms4cm9TVDI3ZTBnaHJGU3J2?=
 =?utf-8?B?WmhBV1hHY29BNmpmWlFqMGt1OUh5Y0ZIQ2JsclVNYldNOGNjeCtvSmltRGo4?=
 =?utf-8?B?TWcyK04zZHVmV2E0TTZ0L0NqR29USEI2V1Y1R0ZjYU5FaGh6RU5uWU9OVkt4?=
 =?utf-8?B?MXUyTXRLSzBOajlhNnNMM0Ewc0FJNTBISG16QzlVYnBNMDZVUUMzZG9RdTNm?=
 =?utf-8?B?WWQyYUUyY041Qm9memF4aFZiV0haMG9wUmE0Z0tpSDFwYllFei9Qd2lETVYx?=
 =?utf-8?Q?rX58FgELpGhAK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWFlcld1b1I0eEd5YzN6bWZOcFNiV2swanBMekhFVHZEODdnWU5ZQ2xCRTBl?=
 =?utf-8?B?OXYzWnp0RWFrdDlmTGpua0tJYndCb1MvQnM4SSs0dXh0dWRDVk1YSVE4Y2JW?=
 =?utf-8?B?dGxDR1B3QTR1SDNkUVY2elhMY01STkVSMDAyem5LYnZZRElDdkNyalZLeWJX?=
 =?utf-8?B?Q1FJVVlITHR0RVFHZWltVGt1RFV4YzNKSGg3bW14aURUL0k2N3pmUWdpaVBa?=
 =?utf-8?B?YnVFbm5uNU9KeEtZRXBNOUxFTmxMN0ljNFRpNC80UnoxVnhWVy9CTzhucTQz?=
 =?utf-8?B?dC9IOEI5TXVyK3JQRXdpeEJ0aG93bk1oalZha1VEVTZlQTJtbElDdVZQMTlk?=
 =?utf-8?B?Q2lpelhsalgrOTI1NVlKZ3J4dm9aK05CRXpJRDFzcFIyOHF4M3BJR3lvMDdD?=
 =?utf-8?B?MmJIUGQ4c3I2Y3UvVm02RGNwQzJpTnpBYzFtbHgvU1JWV1FubDdza1R4RkR6?=
 =?utf-8?B?b2k0V0Fsd3JjWURUVW9QMjNCaUtBYlZiRlNySWJ0NW1VVmpOSll2ZGh4Z1pz?=
 =?utf-8?B?MHMzYmtkT2t0bEh4UTlwazQ5aWRlakgwUkxPM3dKUWZhQjhuQk50UkxnUGFy?=
 =?utf-8?B?NnBXclF4b1ovVEFzUEZOTUZHNlZ1bGlBOGpQZ3FKNTVvSzhSOHJkcnB6V0Nw?=
 =?utf-8?B?ekJMSzRuQWRYS1kzb3ZpYW5NYUtGYzhHQzJ5bktiYk93Z2Flb3RjQ3IrTW4z?=
 =?utf-8?B?VEN3RWRkNWw2WHN0RmxBNGk3NThRU2pFUDRISlZLWnZ5TTJSZkszN09xN2NY?=
 =?utf-8?B?andUc0FVblRsLzZzcTV2RG5mTHFwL0FFNmo3K2Z5bDJaQXlhV0lMQnVIYWc4?=
 =?utf-8?B?MUFvajc5UFhEeEYvNW1MSlFOQXpjanhHazYwVGhxNU1jU3VMeGppd3czK2tM?=
 =?utf-8?B?V2VORWpmRDJVTTdOeVJwMHYxMkc4RUxXRDJBYkFFRG5JY2ZubElvZXZkSWd6?=
 =?utf-8?B?elJqOHF6WUpkMlpkb0p5V3NHcnVrdEpvalZyZ0FpbVlEalIyZ3ppT1hvZjBR?=
 =?utf-8?B?T0dLa2M2bEZZdG9KNEJDZUtRc2dGMXJkakdBM2prVlJNVkpUajQ2b2ZiL2dS?=
 =?utf-8?B?TnZ3VGIxT1R6eXUvUk5Vckk4blMwVjMwRTlSTkxYWmQxSU9iWTJuRW9PN2pM?=
 =?utf-8?B?OC9VQjFWd3d1aFM1UTBSRWtZeXFvMm1rMi9TOWpHeGhlbmJzSm92WDU1ZlQ4?=
 =?utf-8?B?bDJNaEM3cnVGZEN0K0lmTUhZb2RmQTVEdW9wVTZpYmN1UWdkMnM4K2t0eEcw?=
 =?utf-8?B?UC92Ui9KcVFCSk5DaHpQcnlrdnZWU0Z6ZTNYdSt3WTdEYU40MVZSaDVLeHJp?=
 =?utf-8?B?ZlhOcUZ4WitkWDZaZXc4aUJ1OG5YTGVRZ3Q2T01XUXJQNW95THp6Q0pTWlZS?=
 =?utf-8?B?WExjeWc1UnM1VFZ6bTJleGZTMklWbmtjbC9Pd0JuUm1mNE04SkdRWnhLaEp1?=
 =?utf-8?B?TVhCTSs5TDQwTFdyaWJwYmZRbHpXa0hUMFpoajYwSWRmUTFRbHFZUEVPTjVr?=
 =?utf-8?B?VVJ4emNJalg3RVRqZnNuRkNWRVpMZC9hQTZkRW5LS0ltSUlzOUJoYXBKWWhu?=
 =?utf-8?B?REJJVUtubGVsZHAxZ2pGVC9aTFlBSGgrWnFFNk9GTTRQNlNzLzBWWlgzeXVt?=
 =?utf-8?Q?3h/AbmpTMtWBGK0iVlFnDQdAKB667Lg0EnLErOHmOicU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39847a92-3737-45fa-d510-08ddb94c7fe6
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13853.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:40:37.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13984

Hello btrfs mailing list

I am facing a device detection bug on multiple recent distro releases 
and rolling linux distro. It is a bug in userspace and not a bug in 
linux kernel. I was able to test different linux kernel versions from 
6.6 to 6.14 on some distros. The userspace with the problem shows errors 
on all linux kernels and the userspace without the problem works fine 
with any linux kernel.

The problem is that lsblk -f command can only detect one device in my 
btrfs filesystem. The filesystem has 3 devices. When I run the btrfs fi 
show command, it shows a "Some devices missing" error message. However I 
am able to mount it by using the device option and specifying all 3 
devices manually. After that I can see my filesystem correctly displayed 
in the output of btrfs fi show but lsblk -f still can detect one device.

How could I inverstigate this issue further?

I previously reported this problem on 
https://bbs.archlinux.org/viewtopic.php?id=306625 and 
https://github.com/NixOS/nixpkgs/issues/408631


I copied following output with OCR so the result might be slightly incorrect

btrfs fi show on archlinux 2025.06.01 livecd

Label: 'HDDPool-data' uuid: cae95f2?-f8c3-48c5-96d6-e263458efda2
Total devices 3 FS bytes used 10.49TiB
devid 3 size 9.00TiB used 6.96TiB path /dev/sdb
*** Some devices missing

btrfs fi show on archlinux 2025.01.01 livecd

Label: ' Rescue3' uuid: 623630d3-64d8-4917-ade8-412101d23b40
Total devices 3 • FS bytes used 10.48TiB
devid 1 size 10.91TiB used 10.48TiB path / dev/sde
devid 2 size 14.55TiB used 10.50TiB path /dev/sdc
devid 3 size 476.94GiB used 28.00GiB path /dev/sdd


