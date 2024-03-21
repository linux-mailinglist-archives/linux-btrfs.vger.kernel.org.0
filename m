Return-Path: <linux-btrfs+bounces-3485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59852881BDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7532A1C21787
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04466C2E9;
	Thu, 21 Mar 2024 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+PY92gj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OXREVzVI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB690BA56;
	Thu, 21 Mar 2024 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994870; cv=fail; b=RlfHRnZwaa+TnFdxxl861tsVM5Vb4KPcC9j2DMeCVgNFWi/tNf+z/CdYpjly0BlQtvnlkxef5Ia73BIiEqlPJAWr5kzd1jyAPK3QoWnOqLjdOvAiKfDACyRoqg9qhTZ7tU97SOfeRXctTTNyaYaKJ+0POBXcpb2YuC2Eb+ahwLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994870; c=relaxed/simple;
	bh=CEFAhodTsZQaHzDFOWOe2wybmy0vFcrtW69TAudstng=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpm16rOLon5Cw9oTO+8SG1ZIs8TZMwyjUMmskb0t8RRiDpWbRo4HCDWDfmmnsuN9obJtCb4hH+0tfZaqQi6MQxXH/u711iA4Mj0cMtcUeDRqGH7XiEQc4uC4LR5voyXDGdW6RSmi7ljZwV2+h5uBj8GqkxV8ZeUcIdk5qHMJJGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+PY92gj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OXREVzVI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L24h1H020755;
	Thu, 21 Mar 2024 04:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WNOVTYllFMHR+PQHonmIzjRtZmBiPMhnwiINjXVnYTQ=;
 b=M+PY92gjSsy1GH9SYRNhHRibsMu6pqwAArzfRDEIiDJiI+4IE2HW6xLKRSXDF9pWQ5sR
 Aukvqg1Y6VYRbKUAwdhzQjW6W0D5sLF/RhivKu99PXPHEdpuoGgOQLaq53ZM1078vcxU
 e4sZdxc900kgC3Z8c5Hi8q7/1zSKxOwnByWKzpd+vDjuocVCTHmStnBL9BXulq+earE0
 ZHmtmYz2N9bMMKZFeoaOQXSde50mDMAw24UdReaCpkvnGL6m3pQ2mxmn2cwSl2vZzB81
 q0IFY1hC1CRg0km+VH2hScjn14setLMQWDtb3CPp1x3N6/5h2AeRkYeuZyaueLBt3vN8 lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2119jwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:20:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42L3xNA7007835;
	Thu, 21 Mar 2024 04:20:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v8qbv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXKMfMidSc9cutySEnFdx8zGFb0+MidFXp96Ti/dRPi/BjMGr9A5k6WjJDQmt/Ubi1ItUzCRS5StA+ovfGFsOws1qvGuVLP9tKNgEwaNoHshpPaLX4LwIHM46I3W9orfA2nE2jA9UJimLwSBFhyPkXH8aYQKd6r/ym3lAbiUJLQpyh1jhtkm3djLCqXUgSKSgFMQDbuGx2bcPwW/qVX4Tv3dOFHjKGwNE0SDngdRmysIrVqeyyPXb3UXD++Z3LIUuJxRBA1H3pVERywChw2N3IOgVvTTlBEKhv1j3YOGR6k7tyq3GrPA9BxuV9WgbPUvqc83aQOrKt2q+uc+l6szOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNOVTYllFMHR+PQHonmIzjRtZmBiPMhnwiINjXVnYTQ=;
 b=iejDWAOOMr87nsZrphjFyeec0DWK9Sr69+BKFO90ZwEYav3tDTrvVUkXF/BNTR1F05Yk+FNU4Ix0qZTtfYrCnyFHEOKq/9kKyEWoSIjqYGRpTVASk39QUEK1rN2Mm+Nv5FtfNxLZ5yA0IeZJzaD5VVJuuR8Vm2NFQOElJy7obmc5Gly0nw9EpxgeFZvFQCNPSK+1DekJeDdc1nD0uPDR/TzywClFENaGctlsYjycTzaEhwV2ajSvFVrgL75eRTEZqxw8QvZj87nJppdZGucIht06r2lnpnT5+fX8rpAoDs872RPSZOezMuIfoYjLjx651xbEcgVC1JtJGBEsp7GZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNOVTYllFMHR+PQHonmIzjRtZmBiPMhnwiINjXVnYTQ=;
 b=OXREVzVIagdgsDSE2RSR9ivUg+5Lvyb02D1SasA1MfyRurcPmPmUrbVfXi8poe7FgYcmoowpXSypSsLyqT2F2gNF4agn4Wp5PUCRZ+ihMloT8Qn9qgzmbb7rTNSNrB+1rUy605czZjQsYvbNHZ8wu+rcxTZ8jH5widibnuBeqwg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 04:20:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 04:20:52 +0000
Message-ID: <af2c25c6-53ed-475e-a167-f06c479e2948@oracle.com>
Date: Thu, 21 Mar 2024 09:50:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] generic/808: add a regression test for fiemap into an
 mmap range
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f81f40-0148-47e0-9ba7-08dc495e4ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uKY+6bGBnMHYhS5cIwuIT1kRwASxPE8phu99isMr6If1LaLpJDLGEZUdtT5qlR7TtWUpNVa52kZmtgg6+Mu+MjaVFS0pAu1IFP70fKU165enOneshYLN8VKBilwHYv5Z0HweneWRhDEA7Df27tGPjBJRNRdy355q/6pZ95Rb4fMIJzkjJ3yzj7Y4QRF3ElnDnXVPhqqliOI+9mKzolR4yK9xw5niGZSHtN3nRb6v+ouQ/dvEanqh8vLf+QqCk/JSjv0jK3B69ZSEA4VMIrqFALIuoMvJgmENHJZGFYHpyqHOgma/eeTK5RqFFHLNJiLI+v9MocElsz2KioKniXTiykj3ze+Sxw5xfiQbhUoIIWc5BJe9yhVZzlLk7pwZw/Zg/OFIMW0lU3NNdWKeDvu4BJebaxQJ341PWGGK9odwMo4OFTl9z+p44tA4JBgk+0FGvWBOhwV2ksYAzvFfX1AoRh7jUc5+jMGDv1s8aQL3ww3N9OloC7KBi8okbNfnXTiMlFf8cw6BuHxRP1dwJUfuKdFcFbLeigFKwGnzkgFPHciz6Q4re4dM3JcDrsWylN1N67zPYJhCsFxlus+MvFkr7oqQ7X5S4sdbbW2X5TcNTpwolNKQDZf+XyqxLWT2tIlf4Rua5k9v+5CdbiWvAawJUEQcwG0xwnMJUJvbtOPrHfw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDY2b3lMNjQ3a0NMdklWYStXbTcxd3JlUTd6QzNqem12K1B5MER4ZFUvZGVp?=
 =?utf-8?B?TjRSVzdjWWZqT3B4bXNOMkg4dkM0dmQwNDlvU2JCMW1uME5QQmM0M1BmdTFs?=
 =?utf-8?B?SzBuZ2Z4anp4VGI3cGJDZVFqdFRjeDB1dThKREJTTkNRTUhybXNaK2d0dy9p?=
 =?utf-8?B?bng4UGJpTWVVenM0eUgxdjZkbkRDcmtHRkR0RStPblVubEJuckZyR2Rub0JB?=
 =?utf-8?B?WWpIRjczSktaUFpQWk16cEVpN2kxMGVqQXZEaDdiWmMvSVRaUURpdm9XTkhY?=
 =?utf-8?B?Z1FPRlFwVi9BZ3YyRXlnY2FGd2xOQlFkRThJdjY3Q1BCZStFN29Cc0ZuQkxL?=
 =?utf-8?B?dVh0UmVwd2U2ZDJxYWdOQllmNWhRaUpyRG1uRFdnZVBuMUZZZm9Ya2Ruc3g2?=
 =?utf-8?B?SURYaGdJam1Zd05tNXFkZGF1d2lTREh5a1RJd3hoWWJseTZjY3BwRlVSNS94?=
 =?utf-8?B?Kzd2dWlBNVBteU9XaG9CMWJRQ1hrZ1ZVdXZ6bURlREYyeDg2cUh4NHlJNFRy?=
 =?utf-8?B?UmUza1VEblFyV1hiSmlUM2NHNTEwOXR3Zko0aXlBbGpnNkZtN3NxL1dVdUFj?=
 =?utf-8?B?aU1ObGVTUzFaR0NEMHRDQWpiaTRnUDRWVURGTElUQmFUdFBrNXVaMy9tek1j?=
 =?utf-8?B?TFVKc3JkYmdhVG9LMEJPME9MZHEydzZ3UGd3L0lGWU02NnFqcTBWRnBGYWZK?=
 =?utf-8?B?c1Rab3ZIOUQ3Skl3cXh0am84cHJ3UXhvR3pKc0NRWHE1cjYxT21IeUhnOFdy?=
 =?utf-8?B?ckVOM1NqK3R1ZlRkUjRlVk92eEprSlFFdVY0RnRYMmZITUp2NG03MmVUTW5o?=
 =?utf-8?B?ckxka1VtUkNiRnZERkl6R3V6S252WjRBc0Z6TG5rejAzeCsvU1dkTGFBUit0?=
 =?utf-8?B?SWxvR0p5TUVTN3g0S1RjcjEySVc0OWFFekVxNXRFTE9ISzlkc08rZkhFSzdt?=
 =?utf-8?B?VmlHdHJsL2toODV6dDB5ZHdEMHhxWmpMRkFzZ09JTENhcEtsVG1sSEx6RWhr?=
 =?utf-8?B?ZXVUaXZERmpab1NkaVdZcFdVeVBJdUoxY1BEWHIvc3BsK1BVVGNtNTdldHNi?=
 =?utf-8?B?MUlab0tzQVllQjNhbGhrdk42LzBVb1hBUE9lWlRPeGJDMU1SWjlQTmROenJU?=
 =?utf-8?B?a2NCRWloODZEKzYzR0Q1Ni9iRnpzSGx0S0VhYVN3bFdGM2Q2ckIvaFVFdkRv?=
 =?utf-8?B?Q0o5WTFxUE16TG9qbVY3R2dFOFFvR0VUSEFVK1BpM3lsQURvVUFIUHY1RDg0?=
 =?utf-8?B?SDI2SzdNVU9lLzlXbU1QeEY0Q3crNnQrTGN5SnRVcW1GN2tjbG9hZmd4RzQ0?=
 =?utf-8?B?NzBRYWlvNU1WOStmMDQ5RzMzY0IvUHZwb0t1czZ4WDYvZ3d5blBqZy9OalM1?=
 =?utf-8?B?Z25DcVFVaEZFRGFLWkZNOFljYTdyS1dkRXcyQktGdmwzTlo4aWlBMjBKaFcz?=
 =?utf-8?B?V283WGRraSt4TUxXNlNqQWFCRWVqRkRMY2ZjV3VHMi9wRDlsbS82QVFYais3?=
 =?utf-8?B?Z2oyZS9MQ3ZXRFRUS2pTWW1VWmFIbW5GZkRkMkJ4WmloRTFGeklsdERQdk8r?=
 =?utf-8?B?R2FEb3JMVWg5UHdubDQrb0R3ZUdCVEtXRjJ5U1dTRzhaYnJPWGF3bEdZYm9J?=
 =?utf-8?B?Rytxakw3eVBwQ2N5UHFNTERML2dBRzhaRnVmVFBER29hOTZRUURjMXFSeml0?=
 =?utf-8?B?MFNvSmR0Q212Rkx3TVAvdytObDd2NTVlM3RSQVVoNGVaUkNuUDQ1dXBMVFpx?=
 =?utf-8?B?UlJnY0w2VE8yL1VtaXRiUlFSTGJTanJST2pQZ1IxOU91cVpxaUJ2UmhrV3N3?=
 =?utf-8?B?SjFaSU9pS3dDTXJGZUpHczhBMWViRFlJbXJwU3RRN3VodGZkT1dVZ0phdlBt?=
 =?utf-8?B?Qkl4Rjh1dFUyTjF3emd5ZFVoM3o5WWcxdXkya09MbURvbG9qUGFNdERSZU10?=
 =?utf-8?B?OGhpRkx6RE9qa3VHSmNjdXRmamJPK1d5RnJvNUZKTVRJbnFna2hNenNFZGhN?=
 =?utf-8?B?S0I0MVRFS0RDbjlMeERtU004V0NxUytOVG8rcS84SkJpVDdVdkZ3ZlI2OTlP?=
 =?utf-8?B?ZTV0NXM3ZTNLM2dqWGh4cXBCMnJtNlZ0RFdqVFlTWE5veWJ0eXJPM3kvaEg0?=
 =?utf-8?Q?j/7Z/nTxpz8Wy0UY66xWzrH+5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l8DdhngVmIId6uvnfm8vLbFH/tSeHBeM/SB/NDQuum+nuGT8tS7+ox53UAIbc0MlaJx2xhx1GpEmyuYJ7C6EqPnnegmmsoe5GbDZOJUyoh7FUkz3azYDP4dShquBwYmBnjHoxnSxH8mezIBbHRWzgYQUPjC5Iy5TkU8CK6mSJGABYIMZuGgQvOEjs6cDcnZUsX46k5rCvj7QeYFolheKl7p9j+Ixx0Xkek7vE7dOPDQkv9EzEIZ/3IHWWkGOCqQZrDfzCXzRbB/tXXz3BxTzZIagFJo0qgyv8Mn88fGng5pZI32KUFSg1g0QEKfeKLqBFU/SF4N2LDeEz8BsMYuoHd0R7x8flDQyqeFAbC63GcxhV4XrsSncWi20qu3WFZjlwIArxo3GDWRF9DQmbRM6kan5YCx84W4jheNVMOjGnV8q4uHGFIzVwr0acOL2WUDWOGcYqghWPNv7+iY/jz3JMdOGcSdbrLZUGGEc1ItFSNvCTjMojSa/tOpXtk/609H9HymV21M1lTkkVORkvAzmzmGkAr0lbuRB9DpK3ftLS+Ps998cB76R5O5FOP2WJTU5ADe9qkw4zAEatlMdUkLUe9rG6jpGe/FRAVdlkFxWHJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f81f40-0148-47e0-9ba7-08dc495e4ba5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 04:20:52.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhPoHAa6UsfJFGGJLCPlra+W63QhlHD0iXslKw5rJIqGNbqjsQ7guleDJz7QFpxFe/pnwW63nKm8/DXfBosHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210026
X-Proofpoint-GUID: UkwPyLjy5kJFx0Gk-wajJMudflfKnhyE
X-Proofpoint-ORIG-GUID: UkwPyLjy5kJFx0Gk-wajJMudflfKnhyE

On 3/20/24 20:06, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - Add fiemap-fault to .gitignore
> - Added a _cleanup() helper
> - Just let the output of fiemap-fault go instead of using || _fail
> - Added the munmap
> - Moved $dst to $TEST_DIR/$seq

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

A minor whitespace error below, maybe Zorro can handle it when applied.

<snap>

> diff --git a/tests/generic/808 b/tests/generic/808
> new file mode 100755
> index 00000000..36015f35
> --- /dev/null
> +++ b/tests/generic/808
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 808
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
> +	_fixed_by_kernel_commit b0ad381fa769 \
> +		"btrfs: fix deadlock with fiemap and extent locking"
> +
> +_cleanup()
> +{
> +	rm -f $dst
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=$TEST_DIR/$seq/fiemap-fault
> +
> +mkdir -p $TEST_DIR/$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done
> +
> +$here/src/fiemap-fault $dst
> +
> +# success, all done
> +status=$?
> +exit

> +

Applying: generic/808: add a regression test for fiemap into an mmap range
.git/rebase-apply/patch:177: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Thanks.

