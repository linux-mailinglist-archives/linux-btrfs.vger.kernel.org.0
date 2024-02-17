Return-Path: <linux-btrfs+bounces-2466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA8858D28
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 05:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69E3B21FE7
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B821BF3F;
	Sat, 17 Feb 2024 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AnDUemnT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YvFBS7Jn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCA1C15;
	Sat, 17 Feb 2024 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144304; cv=fail; b=PoLyw9PuTH6rbAIghS4MBnWkO5eqJ1alKAK6F4WEwrjddpX1Vwj3RXqJMhqi9Jz2jKbPTEXh1+TWLgYoQuILd2jL228pIoE4AOcLvwgqBJ/LO4pAsOwb1NMkrDFVbkg/JcmVTEKFBpuoBQqABkmATyNaqqve/lT0yaDoW7TaxqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144304; c=relaxed/simple;
	bh=CEHW1rONELDFaDb7kIf1+Z3t13H+XMmad8MimTP+mI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sbbfauIX7J9dKmy9WuowwlsUF1a1FuGnPeXbl4TgGTGN4exkUanPUYRTeUaRhLlwU8Jd+qWUeek3gD7JSxYbI3RZfqKWlevRC6MS2H1V9fOZC5eNYLJn1Nsa1fny7dZapZEFUTqXqy3uCA68IYa83e3TNuSaJ1oBd1O/XeLjls8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AnDUemnT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YvFBS7Jn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H25sEW024278;
	Sat, 17 Feb 2024 04:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YmHysESDr8oEr+PrHIwImV+V3t2hj2Tce0go1wuYS+I=;
 b=AnDUemnTMwa98d1Q+W/Cla4TM1D4vpyXgO4Xjr8z5o4sGV6onqauTV52YqLHULaG7Cbo
 ttBPDNawprakEj//4oJ6WQ9WGgJB7kcev5GBZoFJWd8Ok4ZNzLUdhP4hgaNmfkpGgZmr
 iuRxOcqzg4V7mpdeuatwpFWKhrLhQtJqCacpCKuECtltxReWPl7iHYQqR8Trfglo1924
 acphy+zzR1RPEnO44AvAF6i3uItUqec5ONX8sFVjmOjxVqXYHVHuyjHtlzKdTgWlCXMd
 C4eiEyATm/3SpxAgwJXGHCL4+RDCQxGr1cTo4Mm0sZGSW9T3SjsEnOv9OZTqSEQh8CZI pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc05bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 04:31:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41H1XDlP029066;
	Sat, 17 Feb 2024 04:31:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak83uaxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 04:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To2oH+ICo4bCJlX/3TOEXBkt6X65UxpyJVAcnWcS1Ae6u0jd5OTM6v6FDqovDWVOr8G4jBfZBdItJEPNdahKOEKYRFPM+yZoBziAgIdTD4az/z9KRD/EFWchi3tRTGmihQCpXXIFzuBJhklhpHrcCAv8OM33ElLKytY/fuHfLxDcAn1ZfdyzATfarxAUSc3/kjfWV/50hD81V94IvymvJudlosQc6bTOgf8U5K0n10+YGZCSGevLhGbOvoNhl5Pe1UfZ/w08Ltaaz8KOiwRc3B0Ag0Nra6T2hOFf+qUWpGkHzAVGWqAlosCTu+7/Bj4unOJpzG1EKNavhhyUr14u8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmHysESDr8oEr+PrHIwImV+V3t2hj2Tce0go1wuYS+I=;
 b=YGC77CKm66k0JyN17giaQj0U3TsM+6zb6DlBIBlR9z4SD+Ghg2FklGIRTZZZsfKKSDMhZczJRlOnSCf2V6j0qnrmPXUpGW79y1SSEH3jOcwJNTR+4XK8xrGCVBz/nUxqONeRSfTDRz2T4s8NbwptZ0uUULE7xYuQosEvy6TVRspn6hWVqnD5cPMzgv2iksH1mMweXsngeQUD/atRCmspm9PIl4WVB1/lF08HkA2dfVDzgAn3La+VPz6ikMh+MXeJu2gps/pJnEemFtu9o/dpLRn9GVSInlAc7sa/I2Kj8FJ+iVDGkoY3fTBmZDXzIatszJFNCxOWK0W4wNCDeVkTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmHysESDr8oEr+PrHIwImV+V3t2hj2Tce0go1wuYS+I=;
 b=YvFBS7JndL4H7FDvCwevB6KFWKT+CMHnQzFATgWyjyU9HopCP9fikDmuPBPLYopOp21smhDEp1jBuxY+r+4ICjHjokrDmrF992HSY3hTkLFLCK9/sdJwYU2Q701+6zo5gdsygjzQYRZ5lBBlc8g6LJhmVQMnXd9BDwyQBsLsN4o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Sat, 17 Feb
 2024 04:31:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 04:31:35 +0000
Message-ID: <72e7772b-5e06-4393-b252-003237e839ed@oracle.com>
Date: Sat, 17 Feb 2024 10:01:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] btrfs: introduce helper for creating cloned devices
 with mkfs
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707969354.git.anand.jain@oracle.com>
 <b6026821942d5898dfc5f60d7a7c2b19574f764f.1707969354.git.anand.jain@oracle.com>
 <CAL3q7H5fp8=SBeAbkmaJahTYCZQ5LQtbkcXR_2d1tXmhJ_Q87A@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5fp8=SBeAbkmaJahTYCZQ5LQtbkcXR_2d1tXmhJ_Q87A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b107d6c-d1c3-47b1-9774-08dc2f7152f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ROsjl548ETOpnw4bgN/fUWKgKbtvD3tj6U2EXg7ZnrdqmN8vat8htrbMJCLYqeTjy9jJWDj6rRnyLgvPSgUr6r4UxQrNdU7D/pw4goC8CFGLWllOYmA5PE7LgJlK/rUV41/5CZKdHg9U6iBO0OiUvk0OJyAP4BXw3CJcQBPIBMlCJjdjVtut27lH06IyJeS7441ODlT9lDTIEgjMI/+Iry2Uvmz5zbsL/LbMU49HG7rpaKFfo0yb47GbGHltL4J6BihjaFf3E1QnLDam2/MPuA94+/v78avc63LIppVju8fJ0VeMKj1EAR5o4/s0HEF39uvOwgCCfG04RP1uuzdFGY4Ivr6KgDeu0q8dEPs79l4W5ScabX79GlXViQPM5v43baj8USIL2pgEU3HbA3/HFnceNp7TmRSNGDHfnSpVh74aVrfD/lhtJ8pWilxMkj2ChjeDiciOePgO+RjPH478NSJ8fe8f1rcQFMHdR5bLhcR5jKGKn+nfsylT7vQTs+/AQD+5J8M89bS11cD6bCoZvZGiiGPAGQzbdUYV6g7T7rrIJI0+qGz4dmq8OyiTmPT+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(478600001)(6512007)(6486002)(41300700001)(6666004)(2906002)(4326008)(8936002)(8676002)(5660300002)(2616005)(66556008)(6916009)(6506007)(316002)(53546011)(66946007)(66476007)(44832011)(86362001)(31696002)(83380400001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2o5YlNKUkRpdjY3SXcwZzdVTDR1V0lhTGFsMW53OXhKWG9GbzB4Y2NhNDFQ?=
 =?utf-8?B?VDBlZFR6dStKaitrc0dvK1hxUElRd2QwMDdiZlV4RW1QTUY2R3A3WFlyMTAv?=
 =?utf-8?B?OTlyeTdwZHB6RkdGVHpDVXBtT2wxWHRTQW51U1V6NU53SFNVZWJYdmdjRnhi?=
 =?utf-8?B?dDBRREtyWkZyaVBoUE53QkJwMjVVZ1NxK2J0Nm9BaEJrWmtXOWVPRjJ5Z2FT?=
 =?utf-8?B?Z01EYjdYYU1qLzlzcWF4VWErRnljWXlYbEV3MFRKNzRYMDlkL1Rqd2s1SUhH?=
 =?utf-8?B?bGRGTmNHdzlzTnVTQUVLU1hjUURUaU8rNktObnJEZnZadU5lcmM5WWhXRmpJ?=
 =?utf-8?B?VUh2d2xja0ZqcHNDeURrTE4xamVZRzlSYXM2NFA3N013VEI2OStsT1ExN3JL?=
 =?utf-8?B?aWlkSGJua0lRa0VwK0NUZTA2NzQybXpwSW9ZZVpHZzFUTk1pc3JIN3lnbzRa?=
 =?utf-8?B?alhsKzAvUkl3amptRHpZcEpzUGFmSjJ4Q0dLVXFudXdRcnNITVVyWmc5aVRq?=
 =?utf-8?B?OTZ2OXdnS0hjNU5FdFhGa1l4bjJHYUlQVGFBWHZoNytJaWs4NWdPdklzMDZt?=
 =?utf-8?B?dUhZdGdycENPTm8ra1R3UzhlT0FKQTVkOVNFVC82L0YrWncweEIwN1l6UGtu?=
 =?utf-8?B?amc4ZXBUaHFNVVJlZkw1TG4vRnNjVzRPWE90blBkdXJGRUY5VGhJYTZtRTRo?=
 =?utf-8?B?TnNsOGVZcm90TGgzSmRwL2FEUVpIaHVWTGRDSlRxdFZWYWtTYnNHRVFpaVZ6?=
 =?utf-8?B?SkRvOFVxZnVyc1FyQ3NoczhXWFJtSys0TmRJV3JXUjJFY3hTRjY2L3VKZWMr?=
 =?utf-8?B?TWhNbk1hRWFzcHNBZGc4L2FyNThVRUozV0hXWi9rVVFjLzR3U2prZ2VmVTIw?=
 =?utf-8?B?dlRzNmJ6Uk05dk82TmxPS1ZwS3BLMjZQeUJPWE1sWEJ5TkFpVXVlS0I5aWZl?=
 =?utf-8?B?OEl1RkdUbk9yOFRyWnhTamQ3MVczOGxvTjZCRzBQVk1zYy9GQVpNMEpBYmtD?=
 =?utf-8?B?bXlNQWVxaU5KN25rOFg0aDlwMmJjL3dtRmdJUzZsdVpubUcvUzJGVGtBMVRE?=
 =?utf-8?B?N21qYnpMb1FZZVNaT1MxZVZHTWhBWFdtWEI2TXZlMndiSjZMYVZaT2JiREo3?=
 =?utf-8?B?TDhYVnUwMUJrZzZIR3VvaU0yWUxZaDkybFIySTZjc0cvc0l0OUlBcFZ1ZFVq?=
 =?utf-8?B?L1p6ZlRXYUtrWEJ3d0ZiMlVnUW1TWll6b2EzcVBHaCtwNUV1b1I4ZnpCUy9L?=
 =?utf-8?B?K3VKcDAwZjVmV2dkbjZjdHlicWZNcGxjM2hkNlVOSmF3SWJkR25yRXMweGU5?=
 =?utf-8?B?QXJ5bGhDZTRMSkd0OVBqWkNwanBlN25RK3psaUFOYUhKMlpjYnBKclhINDJk?=
 =?utf-8?B?NWdwUG8zQzJoa1laYXpubExtSWtaSXZ4K2xJazZwVEVaRGI3VWNSMVZpTE9X?=
 =?utf-8?B?SWxGeHlFYllCalF4SjQ0d0VRR2I5YkE5ZVlxTlV4c29KN3AvSWgvK0lVeVJJ?=
 =?utf-8?B?S0xSVHdpeXRGenZJdSs1Ty9EcWJqZEYvYlpsSElBSkNvNGdFQks1S1lPN3F4?=
 =?utf-8?B?bkhnZzFhaVVFY2ZoZy9SQmVDMFlaQzBzU3I3MlYyNVB6SVNDOHhQN2tZc3JH?=
 =?utf-8?B?K0RhMkx5Qzh6Z1RJZDlQU3lFdUJYdHJPOUk5SlZaMEJFUlFmV2NBRWczaTZR?=
 =?utf-8?B?UmFub054ckVRbmg3UkJSZWM4K1pOcWhwMkZJYVdZZnludDl3SENuUzVCYXhG?=
 =?utf-8?B?WWE2c0Z3UWk4TzIzWTdGazFwTDYvZXgxWUNyZnJQR1RPKy9uM3o3R1F4eDhv?=
 =?utf-8?B?eVNoVk9EZnlHbG9Qd2pxWVF4dWg2MkFVcnRXOGt4NXNiZkN1cERweWd5dCtB?=
 =?utf-8?B?SVhRZElFcHpKQUpQRm83Rnl3N0I2dVNXdk80OEhOUElGWTdYRzFjd2JSWVpG?=
 =?utf-8?B?b1cwU1NYQlJiMExYYmw5blVMZE9wejN3Y1QxVkpZRzNZMUpEVGdlQVVDcWUy?=
 =?utf-8?B?bERLalUwYytIKytZQ2xMR2o2MEN0cGFQQktJSnV5ZDZqZHlTUzB3Qkc1dmox?=
 =?utf-8?B?VFU5U29UYlMxamR6UE5zNjlTK3lmNGV6MmlTaDZTOFo5WjV6RWs1SE1Rc2Ny?=
 =?utf-8?B?WGhLV1BlcUwxSlp2NHBzdU5hUmN1QmVxVWdxb3ZobUxkdlN3QkRFRVRMcDJU?=
 =?utf-8?Q?ESJiJciu+bmscefsduRI+wSrzFxGnA9owp8Te4N3UbDG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gv+scGXGfPq8ZOf5m4qj2mu8gYZFagJGduYLjN8nQaWP2mmXGICcoUIw3gxj2EOkgGKSm2dLaE86OnRNS7vU9VTxsqgjygtqzI45tRjSOUfBhT7ezQOEu9ylCTOMkIh6hDSNyhx/BqIniY0hubqUtdSBGWEDrOrvWRebIfN7/kZ9hBfdEowtPLbuL68KF7iopcuQvHTal6/VKURJJlUinH9S2bLCuMTCAUXIdObcOdfXmvUDcU3HUL+hyX9WIfEO88f29aju6wEmhMEqdqNHZRKvO6Q1ObrPk++N5Qz7p+rMtzr4Gn7Fa/uDBbF4RVQPpghEJky+DlLXr4MITz8l0h+F8F+O0C7O6/ll0EmfI1liTbLfICR0fyyo+Fx4PfnXr74HqvH3D8WvGU9aTr1Fx41v4sGOUBOQRt0R7wuAtHpiJo53wYYOm6JgJVYL9t2a+EXktp7eaeXjzqlaBiPRmQoDwgjGg+YCSDaPEB6ZDSMAO1wkROm1qoUT4LfuqYeEdxP9dBe8PChCVRycIjjL63p0ToYrehkD9fRtomvq3Ves3lqvQLGfneZY98oPjR2aX+I7qM1pn1UsO1A3pm4UhTqAJm73E6W5ZVIS7LsaTcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b107d6c-d1c3-47b1-9774-08dc2f7152f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 04:31:35.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rf8RoPitrHRB+oJs+qMMYNh4NHm785qmOmk9lO1lKOOspggN5AfTR5ZAWSlxQrrlCPFBPQgPbi3EfOQgWGHocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_01,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170031
X-Proofpoint-GUID: -sW8Wgemmg_3qCdEp6rg-DoN9yRgt_yX
X-Proofpoint-ORIG-GUID: -sW8Wgemmg_3qCdEp6rg-DoN9yRgt_yX

On 2/15/24 18:12, Filipe Manana wrote:
> On Thu, Feb 15, 2024 at 6:37 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Use newer mkfs.btrfs option to generate two cloned devices,
>> used in test cases.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/btrfs | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 9a7fa2c71ec5..8ffce3c39695 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -91,13 +91,7 @@ _require_btrfs_mkfs_feature()
>>   _require_btrfs_mkfs_uuid_option()
>>   {
>>          local cnt
>> -       local feature
>>
>> -       if [ -z $1 ]; then
>> -               echo "Missing option name argument for _require_btrfs_mkfs_option"
>> -               exit 1
>> -       fi
>> -       feature=$1
> 
> This is confusing... It was just introduced in the previous patch that
> introduced this function (_require_btrfs_mkfs_uuid_option).
> 
> If there was never any need for this code, why was it added in the
> previous patch and removed in this one, without any users in between?
> 

This change was mistakenly introduced here; it should have been in
the previous patch. I will move it. Thx.

>>          cnt=$($MKFS_BTRFS_PROG --help 2>&1 |grep -E --count "\-\-uuid|\-\-device-uuid")
>>          if [ $cnt != 2 ]; then
>>                  _notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid option"
>> @@ -864,3 +858,21 @@ create_cloned_devices()
>>                                                          _fail "dd failed: $?"
>>          echo done
>>   }
>> +
>> +mkfs_clone()
>> +{
>> +       local dev1=$1
>> +       local dev2=$2
>> +
>> +       [[ -z $dev1 || -z $dev2 ]] && \
>> +               _fail "BUGGY code, mkfs_clone needs arg1 arg2"
> 
> Rather more clear and informative to say "mkfs_clone requires two
> devices as arguments".

Sure.

> 
>> +
>> +       _mkfs_dev -fq $dev1
>> +
>> +       fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
>> +                                       grep -E ^fsid | $AWK_PROG '{print $2}')
>> +       uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
>> +                               grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
> 
> Make the variables local please.
> 

Sure.

Thanks, Anand
> Thanks.
> 
>> +
>> +       _mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
>> +}
>> --
>> 2.39.3
>>
>>


