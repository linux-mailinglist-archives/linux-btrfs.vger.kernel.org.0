Return-Path: <linux-btrfs+bounces-1964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56A84436F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0050728DC4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A712A143;
	Wed, 31 Jan 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvNfX9SJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OXy7WQKS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FC433CB
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716396; cv=fail; b=Tjp34fhXAC7pCkHLU+gTaQGLINlSJqnuD67yYEJ8WQrTOXybsYbkdWdzbXun89mZRARAUXtbL1FQTK253SD7jkqtxR9oUn0wUyFIU6zWyn12lFlLV6zCG63GW9wrhwssKRdPz6vVuYE3mIPLEsiEI4FPk+R2QqN0YBzmflyyrlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716396; c=relaxed/simple;
	bh=JSLpFuAQTygHiIQG2xJK2hNMoKw++S2BkVWR8HP2KsM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtALE0QllVn5wayHrhbiPyV3mSDAOEX1FG9NOcoQjt4a3mgQl9pUt6v1yg5zJzYpPUB4jOo5iUwMoBO4kT8FjJ7y72TDB6ni+OQZxYx617V/hYjFgs1JTnrKqLJztsAupfiFgmRXGI6bXY+SRS0oJYv+/omBPfsT2Q51ft2hW0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvNfX9SJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OXy7WQKS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEx2gU009195;
	Wed, 31 Jan 2024 15:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=39ykN9uNt0LzgLnU3f9XiV3weulef7XTJ0NNW4GqzO0=;
 b=dvNfX9SJ8SkluTT2opTLcadfwVhQbo18k6R/TzIqYSBDLuZlMPyhnjopQcT6LQkKrTzd
 DKXnkXZDmWQ3Yv09G1z33W4QOIiRolkB8WUvZGf4j9wWmw49HPC6t3rC+l4y0OjQI9o6
 PmD3iLYooSsN9DszVCEPd41TdwanMIK+foVJubT1ofFRWnIkeafICaxoogBd7WsuqTCt
 Wromu7qO7alK/NiqCREXCOpick/h8CNzJLND8ZPLOJ9FqCazpLkfNPmBOr1ng+MMth5A
 5ZMvpC39AK8F8oc/3FWb5h5KbyodYOtDCYp3phPW+MtzmO5w+VNutxXyVJCUemFXIh/+ 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm426eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:53:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFXIIY011579;
	Wed, 31 Jan 2024 15:53:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr98yce1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky7YwaHtLmxXojxWuEGyx7AdG35N/LPlIDAJqvLC5qmBDiQK4++S1nbussPgC26Fs3+N6x8nrkQaoa+ptB1hlNpYxrbHdgg0+oUZqmehLVjjyAnyo6irKvmwxKxGNR/QnhmsgVho4SLaL9ATvvmsrGEQs8YdbXo3vNP5UB0KuWi7uyrgUb6HFlEb0vlmbn/Gv9dZG6uH3KOfNv0JjDN+Sr9m6LZHWfvU6i0QN4ldtWOF76FeRYxzTQ3lJZi/npAsGiiOrx/AfHd6s7yF8yyJzXfx0qU4tkhKZJG3p6xPqZ9a90XtzKUhftnwdJ0WJV4aTgZ7bC4MKHSW0rqzjUatww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39ykN9uNt0LzgLnU3f9XiV3weulef7XTJ0NNW4GqzO0=;
 b=EzGzdF5SJm3uIzTTAttgq8Ne5KYYi8t44t6KaaOYo8fF9HdSGbp6FykA2opc4OUbdrNzv2OeiYnQe1FbKfAJhgAkxZmW7Iv5cW/HsAqRZVsSYKQ7lj7CbY4fnjGR2cv1IMMxFnZGAt9mAFRk9AY8ce6N+faF9uYIvH0mSC5Kmo0c09O1e32LPhrUYjATyp6gh4ZJfpsuG2FkGNh4ozNfHe6tooNEJDkXQ8E7e/1qlc006+MS9Pv0F1T5WSSwjLolRB0xxG1lEyT0t3QREKNxu57p3vVs5v6jRHAeC708fOQE0WPloafK+EZtWDePWc/RlUVB9v8zbEfAHCvZW+CWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ykN9uNt0LzgLnU3f9XiV3weulef7XTJ0NNW4GqzO0=;
 b=OXy7WQKSCkTwT31/OcCQI1hNtqK6/oBzgizFFopoBjimPAu7QoHQjtN0Xjp91/05W8uEXntbLuhzCOOnVIMTxLm6flt68Uikk8BNfwZ4bpCbiV/o0id9ah2ND+NUzkAkrgADD00DHamF/ZXpiOXlMiXtuy4VCh7LsXEClGDMuKs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7971.namprd10.prod.outlook.com (2603:10b6:0:b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 31 Jan 2024 15:53:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:53:07 +0000
Message-ID: <b5b191e2-27a8-4d9f-92ec-434e7b88d1f9@oracle.com>
Date: Wed, 31 Jan 2024 21:23:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8066e5-3296-43b7-b4b5-08dc2274b7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6B34x4ZIAI26dA1Gxto715+M+lYPWizyjdFN02upz+tByrF7JEz1yg0VWm/0rWcEzejkFlZjVd5MdXqMLSSJIp/GS4LmOkVHz/9WzRQVBAIkSag3qfESgz/QuqL38dW8VYEx3YmUQJDbmbk21P9V76SKdjCRCBBpOouieJUC/6VOUMlaHQctIilMm68vypXSO89ro4Y1anPnKacet5A9IZ8kOael71SntZddBHHXjFhprMAtbL8vW52CJYRkM8YSTxE6H+BrrSOdCGuLHjSNP6P/TFSMQlmSyuXa3+PNoSl95zyOekAOdAVQfVdSQlyA0zpjalQgraF5IBROtV6gRNpxy+cmB+wPxVc76CrlqbAaDqK0CS6mI9Fdq55RVIm7QEgfZOr28v9khjaBVN73D2fhik0pR3i3UO+2QlRhUaOa3Ja7tMOEBP7dPiCYOLvokQDiuJRdshUuuH1EwmYP2ORURsR64Z4xGglX6A3QeoWFy9i8B+YHAP/umd1nL+9gnsS2R1h83xvpzq187AyGlUUgyyYKNpBrsMOspklFaF4SGZg8WELXjqMk6aXUX4E0ghszNieUC954/v38U3rQeNPAxvGEZ859UpxW/N7p5jqITorVvgtfrS46ZJj3ohZMwHzYRBOcaXeQUEr8giIDBI7TAR4EfuW0icH9xZ7aVjNGDhlu0RPTKIK4ryUsAdcMcWrzb/Av4ITil4YMw43kIv8ygkZSwZqn5DCnXGcXQlU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(2616005)(83380400001)(478600001)(53546011)(41300700001)(6486002)(6506007)(6666004)(6512007)(31686004)(8676002)(36756003)(8936002)(66476007)(44832011)(316002)(66946007)(66556008)(2906002)(5660300002)(38100700002)(86362001)(31696002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXJKck45bkdncXhhbjhlQlFKK1VJbTlEU0tnSUZjMWV6cmE3UkhKdUpwSEJ2?=
 =?utf-8?B?ekY4WFN0VE1tMU9pK0FGL29XZG9keEFqQ0w3TkNsbzk2d3pVU0tpbzFqUHFL?=
 =?utf-8?B?a2dCSEc5TWRZQXNYbkZIN0RGQXBmcDQ3NWFXNzkwWXg4R0lvdm5DVnhzakNF?=
 =?utf-8?B?eFlVZWsxK1hMeVYxZHZQbXJyeU1SSmdiQVBxSjlHZk8wak5RSFJsNXBXQVhE?=
 =?utf-8?B?dWs1YjNpL0YrMnFvbThYSy9YZ2ZHa2RvSjdwQUd3SUY1Q0E5ZmVQdWNIdXMy?=
 =?utf-8?B?cXlCT3NBaTNaS2xEaWpGUFV6bTduMWVWb1RwL0RXYlhlcUhUSk9zQ2k3czlz?=
 =?utf-8?B?My80S3hxZnBIQVRMSkRyVExRcWJ4WUREU3JvNkFxS2Z3WmVWWXVNQkswdmpR?=
 =?utf-8?B?bzRObS9sWXZWeU1hYTRISzBYZjNFbGRubm9vN2NlTTQ1M0lyL0loYnJ6ZFVk?=
 =?utf-8?B?N25ubUI2S1NGNGFGUlMxaUxqcFBVNHlvelFaWkVwYWJWbzhjUHQrNE4wZXBt?=
 =?utf-8?B?N0dMVG1OUEhDTEFMYmJuak9EL3F3MnU5QURsU0RFZmNwM3Bab1hOVThEZjJO?=
 =?utf-8?B?TWpQVmNVd0RjcC9jd1lFSDhOY00yUVFSd0hCY3F4SDRoR2ZjS0pwQ3lGcVg0?=
 =?utf-8?B?OGxyM1ZTZmlBY3g0QkNVbXRxOWcwUi9KTjNONFBwblpHZ282bE5pNXFiZVRl?=
 =?utf-8?B?Z1hkVE1EMmdKOHpGa2t4OXhCRW00K2s1a0pMNW9jak10SHNvU3ByeXVsMDlO?=
 =?utf-8?B?bVdmWmhkbUlkb2RsRDROU1J2ZTBjMUdSbmNZTzVGaHlJdFhSY0R2VGRJK0k3?=
 =?utf-8?B?NGQ4TmtnK0xXczNJNjk3WUc4ajdkSVBtcGdNenNLbVF0S1JnK2o1MUErU0V6?=
 =?utf-8?B?ZXlvcGg0cldIUVIvNENMZ2xwbW1aQVJHQlRHeHF1OWZ3NUh5UnVaSE1CTURj?=
 =?utf-8?B?YmpRNEpKekp4dHhmb0h3RUk2aTVLekYwbEUxVVZnVVdpRDYrM3kxMDRHK2M2?=
 =?utf-8?B?L01MZ2UwUnMrYUZnQjl1NEw0VTlySk8veWdOSll1ZmFFN1B4cktLeENOeC92?=
 =?utf-8?B?ekR2Q1QrMXRQb00xZTl0RXN0R093c3N2S2dFU0FwSFl5R3piK3JXa1U0TTgx?=
 =?utf-8?B?bGF5N2Z6Zmsyd3RDQXJ5YU01R0hLbWs4WkliOU9UQ21RbGYxRTNFbDZRajVl?=
 =?utf-8?B?VWF6U2hWL1RqZlJaN1Zzd3BBSy9FUVVXT1VkQnBOSTNmNlg5d29DTTRsUXRo?=
 =?utf-8?B?UzkwazRwVm5VeFp2bHVRM0lkNzNzRHg1eStrejF1UXJIWURCbzV1a3pWZi9k?=
 =?utf-8?B?cGlqbWp6SE82eWE4WXFlcU10NGRLV1llZ1o2TEJGOHNIbXR3ekJ4ZS9xQmZq?=
 =?utf-8?B?ZFgvSTJ0V0liWjhMNEhNZWdlYjJ3VUZmY3FYUjJXRndxbTdweVlCTk1JV0Q2?=
 =?utf-8?B?T1lyeWRhdXp3Y1R2bWdZTW1Db3JhSjg0ODJDNk5sRis5RTF1SS80M3BnYVlT?=
 =?utf-8?B?TUMyQUFRRnJmUlhqeE80cGdJTjdLeHE1My9SQm0rTFFXY2kyaDV2U1I0VnMz?=
 =?utf-8?B?WE9wUVpoV2ZTamg2NWFZdGl4WC9UL25aOWlyMWxmZWQ3SUlSRlI2YmtOT05o?=
 =?utf-8?B?aXRMRTE2Y3k1ek1wNEdnbTJnUlJidWJsM3RTSFlQY2hKSG0rTWVyYUdiRGpp?=
 =?utf-8?B?TnAwSDFRQVk1aWROSmFSMmVobUNkTGNlMGpzQmoxQUxYdW9IVXB4Y004S1pK?=
 =?utf-8?B?dkF0TWx5NW0wOEh1cVpxSFYxNTEzMVF3WVBPZHdqbFZYRGE0Q0xxOERtWUgv?=
 =?utf-8?B?OUhEREg3bVArZ01DNjVxcEhSRzVRcld3QUw3RmhzSUxTK3FRRDM0N3hqbm94?=
 =?utf-8?B?TjVzck9sQVF0NzVaVXQ5L1lXK01kZkRTUmdEV1I0WndIbCt5aXQ0Zzg2ZFVK?=
 =?utf-8?B?SVVjNVBVeUJsUC8vOXQvMVkyM3FNTW5OQmxMVGd5b054eGxyVllreStabGpx?=
 =?utf-8?B?ZlpDKzNwODJYaXJFYllOckJxTkhNR21zTlBkcGE5MDdLY1VRK2pobCtjSWJw?=
 =?utf-8?B?WTV3OHFPS1F3VkFEMVY0c3BjcEdUeCsySHpUVjVtUWFoVFFCS2RQRnpTY2tu?=
 =?utf-8?B?bUoreGp5b2tLYVBsNlNVVkJVanFpaC9tcUE4UGp1WnhJWjRha2hPU3Z1Q01l?=
 =?utf-8?Q?WMfg+HOclPLrmPFrJppiERmnybAHmRnyYcJY+CNAUN6C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6TSkSZ72CuEb61N1x6IqN5cU3kzhuFATzxczZ8OqhCmTBPbD6gpsGliiMOpRxO2AhyVPfh1vC+oWA72lG0ruGIUVauhbDRmMm2AuxpnAlkgjpnyqIIANmQrr/koWvHU6Oh7F+VE7ZZZFwLVicy8ICNNS1ecpTe2hg7RY247w2ZwHjRso1S8Nl0yX/hO84OSsEOb+TqannvWQMq799GIShnS8an9TtZv+LkTKLfZ6mivUKJ0RmHFlFt3RY01TvVDmQSaznIEpz2d3Ir1Pu242f0gbLtkZSAb+XlY0DKoHQzoEfP1y9UJQCTdSaIiu1SmxX7ghsEbhBOVSG/j3q/MxWEdmrKWIe7olH7vfBk6t4+/9afdZBOSxIPlr3X/9dz1tfmij8OjTIiiotLcTgLFWaBsYd9SZx7Ob2fu5DKVzrN146XceTgEUaOWrVqYIBwsKcSeE+QlufIn/nAMWafm3RqT9v4BsV8lmC3YG7Bkt9RyQGnld1B+3YmXt+u/LRfnoqYFnePw2Bf08SBMkiMq7qgaSZnJa+AUFFjCcxHWA/buJPki04GFahUW29/W7pQ108NRsl78HWjizIWyjWwZ3ZNrzv+B00pxGFDObw6m6eYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8066e5-3296-43b7-b4b5-08dc2274b7c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:53:07.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsI7pvHdomqmfHJrlM5LRQydMjfnLCWvnJva0t+b/fQ1KFRewhj1aJYoVmFU3oBwzAPJAR3aeelXwZmjXC7PMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310122
X-Proofpoint-GUID: LaxzGwNOiG2RHZ1W3W-ZWrxuw3j1klxJ
X-Proofpoint-ORIG-GUID: LaxzGwNOiG2RHZ1W3W-ZWrxuw3j1klxJ

On 1/30/24 11:31, Qu Wenruo wrote:
> [BUG]
> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
> descriptors open during whole time"), there is still a bug report about
> blkid failed to grab the FSID:
> 
>   device=/dev/loop0
>   fstype=btrfs
> 
>   wipefs -a "$device"*
> 
>   parted -s "$device" \
>       mklabel gpt \
>       mkpart '"EFI system partition"' fat32 1MiB 513MiB \
>       set 1 esp on \
>       mkpart '"root partition"' "$fstype" 513MiB 100%
> 
>   udevadm settle
>   partitions=($(lsblk -n -o path "$device"))
> 
>   mkfs.fat -F 32 ${partitions[1]}
>   mkfs."$fstype" ${partitions[2]}
>   udevadm settle
> 
> The above script can sometimes result empty fsid:
> 
>   loop0
>   |-loop0p1 BDF3-552B
>   `-loop0p2
> 



> [CAUSE]
> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
> open during whole time") changed the lifespan of the fds, it doesn't
> properly inform udev about our change to certain partition.
> 
> Thus for a multi-partition case, udev can start scanning the whole disk,
> meanwhile our mkfs is still happening halfway.
> 
> If the scan is done before our new super blocks written, and our close()
> calls happens later just before the current scan is finished, udev can
> got the temporary super blocks (which is not a valid one).
> 
> And since our close() calls happens during the scan, there would be no
> new scan, thus leading to the bad result.
> 



I am able to reproduce the missing udev events without the device 
partitions on the entire device also, so its not about the flock.
Also, per the udevadm monitor I see no new fsid being reported for the 
btrfs. Please find the test case in the RFC patch below.

The problem appears to be a convoluted nested file descriptor of the 
primary device (which obtains the temp-super-block).

The RFC patch below optimizes the file descriptors and I find it to fix 
the issue. Now, both yours and my test cases pass.

[PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
  mkfs.btrfs

Thanks, Anand




> [FIX]
> The proper way to avoid race with udev is to flock() the whole disk
> (aka, the parent block device, not the partition disk).
> 
> Thus this patch would introduce such mechanism by:
> 
> - btrfs_flock_one_device()
>    This would resolve the path to a whole disk path.
>    Then make sure the whole disk is not already locked (this can happen
>    for cases like "mkfs.btrfs -f /dev/sda[123]").
> 
>    If the device is not already locked, then flock() the device, and
>    insert a new entry into the list.
> 
> - btrfs_unlock_all_devices()
>    Would go unlock all devices recorded in locked_devices list, and free
>    the memory.
> 
> And mkfs.btrfs would be the first one to utilize the new mechanism, to
> prevent such race with udev.
> 
> Issue: #734
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the patch prefix
>    From "btrfs" to "btrfs-progs"
> ---
>   common/device-utils.c | 114 ++++++++++++++++++++++++++++++++++++++++++
>   common/device-utils.h |   3 ++
>   mkfs/main.c           |  11 ++++
>   3 files changed, 128 insertions(+)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index f86120afa00c..88c21c66382d 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -17,11 +17,13 @@
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
> +#include <sys/file.h>
>   #include <linux/limits.h>
>   #ifdef BTRFS_ZONED
>   #include <linux/blkzoned.h>
>   #endif
>   #include <linux/fs.h>
> +#include <linux/kdev_t.h>
>   #include <limits.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> @@ -48,6 +50,24 @@
>   #define BLKDISCARD	_IO(0x12,119)
>   #endif
> 
> +static LIST_HEAD(locked_devices);
> +
> +/*
> + * This is to record flock()ed devices.
> + * For flock() to prevent udev races, we must lock the parent block device,
> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that case
> + * we should only lock "/dev/sda" once.
> + *
> + * This structure would be used to record any flocked block device (not
> + * the partition one), and avoid double locking.
> + */
> +struct btrfs_locked_wholedisk {
> +	char *full_path;
> +	dev_t devno;
> +	int fd;
> +	struct list_head list;
> +};
> +
>   /*
>    * Discard the given range in one go
>    */
> @@ -633,3 +653,97 @@ ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset)
>   	free(bounce_buf);
>   	return ret;
>   }
> +
> +int btrfs_flock_one_device(char *path)
> +{
> +	struct btrfs_locked_wholedisk *entry;
> +	struct stat st = { 0 };
> +	char *wholedisk_path;
> +	dev_t wholedisk_devno;
> +	int ret;
> +
> +	ret = stat(path, &st);
> +	if (ret < 0) {
> +		error("failed to stat %s: %m", path);
> +		return -errno;
> +	}
> +	/* Non-block device, skipping the locking. */
> +	if (!S_ISBLK(st.st_mode))
> +		return 0;
> +
> +	ret = blkid_devno_to_wholedisk(st.st_dev, path, strlen(path),
> +				       &wholedisk_devno);
> +	if (ret < 0) {
> +		error("failed to get the whole disk devno for %s: %m", path);
> +		return -errno;
> +	}
> +	wholedisk_path = blkid_devno_to_devname(wholedisk_devno);
> +	if (!wholedisk_path) {
> +		error("failed to get the devname of dev %ld:%ld",
> +			MAJOR(wholedisk_devno), MINOR(wholedisk_devno));
> +	}
> +
> +	/* Check if we already have the whole disk in the list. */
> +	list_for_each_entry(entry, &locked_devices, list) {
> +		/* The wholedisk is already locked, need to do nothing. */
> +		if (entry->devno == wholedisk_devno ||
> +		    entry->full_path == wholedisk_path) {
> +			free(wholedisk_path);
> +			return 0;
> +		}
> +	}
> +
> +	/* Allocate new entry. */
> +	entry = malloc(sizeof(*entry));
> +	if (!entry) {
> +		errno = ENOMEM;
> +		error("unable to allocate new memory for %s: %m",
> +		      wholedisk_path);
> +		free(wholedisk_path);
> +		return -errno;
> +	}
> +	entry->devno = wholedisk_devno;
> +	entry->full_path = wholedisk_path;
> +
> +	/* Lock the whole disk. */
> +	entry->fd = open(wholedisk_path, O_RDONLY);
> +	if (entry->fd < 0) {
> +		error("failed to open device %s: %m",
> +		      wholedisk_path);
> +		free(wholedisk_path);
> +		free(entry);
> +		return -errno;
> +	}
> +	ret = flock(entry->fd, LOCK_EX);
> +	if (ret < 0) {
> +		error("failed to hold an exclusive lock on %s: %m",
> +		      wholedisk_path);
> +		free(wholedisk_path);
> +		free(entry);
> +		return -errno;
> +	}
> +
> +	/* Insert it into the list. */
> +	list_add_tail(&entry->list, &locked_devices);
> +	return 0;
> +}
> +
> +void btrfs_unlock_all_devicecs(void)
> +{
> +	while (!list_empty(&locked_devices)) {
> +		struct btrfs_locked_wholedisk *entry;
> +		int ret;
> +
> +		entry = list_entry(locked_devices.next,
> +				   struct btrfs_locked_wholedisk, list);
> +
> +		list_del_init(&entry->list);
> +		ret = flock(entry->fd, LOCK_UN);
> +		if (ret < 0)
> +			warning("failed to unlock %s (fd %d dev %ld:%ld), skipping it",
> +				entry->full_path, entry->fd, MAJOR(entry->devno),
> +				MINOR(entry->devno));
> +		free(entry->full_path);
> +		free(entry);
> +	}
> +}
> diff --git a/common/device-utils.h b/common/device-utils.h
> index 853d17b5ab98..3a04348a0867 100644
> --- a/common/device-utils.h
> +++ b/common/device-utils.h
> @@ -57,6 +57,9 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
>   ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
>   ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);
> 
> +int btrfs_flock_one_device(char *path);
> +void btrfs_unlock_all_devicecs(void);
> +
>   #ifdef BTRFS_ZONED
>   static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t count,
>   				   off_t offset, bool direct)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b9882208dbd5..6e6cb81a4165 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1723,6 +1723,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		}
>   	}
> 
> +	/* Lock all devices to prevent race with udev probing. */
> +	for (i = 0; i < device_count; i++) {
> +		char *path = argv[optind + i - 1];
> +
> +		ret = btrfs_flock_one_device(path);
> +		if (ret < 0)
> +			warning("failed to flock %s, skipping it", path);
> +	}
> +
>   	/* Start threads */
>   	for (i = 0; i < device_count; i++) {
>   		prepare_ctx[i].file = argv[optind + i - 1];
> @@ -2079,6 +2088,7 @@ out:
>   	free(label);
>   	free(source_dir);
> 
> +	btrfs_unlock_all_devicecs();
>   	return !!ret;
> 
>   error:
> @@ -2090,6 +2100,7 @@ error:
>   	free(prepare_ctx);
>   	free(label);
>   	free(source_dir);
> +	btrfs_unlock_all_devicecs();
>   	exit(1);
>   success:
>   	exit(0);
> --
> 2.43.0
> 


