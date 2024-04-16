Return-Path: <linux-btrfs+bounces-4296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB88A68DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FC728B214
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672C128361;
	Tue, 16 Apr 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqYuHJIe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="saINiz+p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12460128363
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264309; cv=fail; b=ZO41LlmXKNQqGjHofG2eOFGrA8L2i/qSa84sofeS0786F+URAEE/jzHGs3pMyeOd0fLn6MbGGpCAzpkHHrmNKWWs5CPj0TW8aneYeo4WFMIZHJJTRG3JzudnoEDjU5AxWnMhhDpDpyN3MI+AyKjNCwYgOQYv1uriOTEqZbl+8+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264309; c=relaxed/simple;
	bh=uHgTJqfH9BQ/3VWulHDglGnZ53bzJF48R48OnW3MATI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRWGUbvW+0CZuFhYBG/aA/n11fBwyWrhDqxIbB6FTABbCZ8zKdbKYsIK4N17na8sUIgwtyHYn6dVDpnItBMTIEbpUAstas1XVBOVfp/uO9Wo38Pt8pwPn4xTXD+XmQSukNuF+GBRI9SSRXAlwsfnfbXNsk5ccVc2BMrxB0vqpAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqYuHJIe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=saINiz+p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8nq1l003267;
	Tue, 16 Apr 2024 10:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zmPF3g1C2iU5iMynpddENX2vnG5Q2jx/VxUe3BQjc4I=;
 b=eqYuHJIeX1zwjK8UVsful14g8GOoPTqTkEZ4GTTOWOl5iaTo31kcwE1sKtAq9kt2/jMG
 AYSoQdLiHxs1ZHoeJIb9b8+ES44NAqn/IG2QZFn4oeha2+kcMIq4LfWZfop/0OYwSvPz
 GCyhw2P/gH9y07BoHO3mFnCYDB5XK3JuOwntkfrg+SlZGKCOSMIO79Db44jNfdwsVIz7
 tWxU63DTz9NmVtjQza3gqUuKRL3reHJbXFguI2JuwS8UQqqM7FARzziqs/fWpz41Abv+
 7HogavkCoajJAlgrec4t0YawN/f+RwJ4iBB0i68qFLko2rQu1nH9N5fymtQ4gXw5oYQz aA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbmus9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:45:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GA1w3D012574;
	Tue, 16 Apr 2024 10:45:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkweysg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX0H4v5gtt1kGjRq3eCOJx8L+Bq0sJnbO3vFccgAT5qcknVgZpXbfcAA19hXMkQ/bagEUSItYBMbmHhOsClyHmyh2RTXOmMf8e7MQJsGXB/EGDwQWw9MK369w81fOXEJabB65R0r8T2zMAB+T7P5QzLIPTyDXwAiF7zQACZX+QmnlXFJuALX9CntSXl3H2jUSRa54JJm0S2d8FNFck9FrAOV9l3x9a+AI48lF/pAJZYBv0CY5hQtEyH9ca8it+eMEcSQQKbWdqo1/tDWpv0PNoZKMslMeWU6e1TXSw0Jbtk02j17jgSWawc3U6g13D0TIQOGxc+bX6YzSxUFeEt4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmPF3g1C2iU5iMynpddENX2vnG5Q2jx/VxUe3BQjc4I=;
 b=NNSImkBEFX/jVo2vxsnyCPz1bV/A2/K6xl8BJBPKsfgf7m9LPKqiISPyT4rTnfKNVO5BmP4r0BjmGdGr9yl+Btxg+Rqb649VAki9oHToog83Z/E6CHoJCMxXyo2jxe9Lwsu2WiJbmVoRk3b9JeqABBzy1nlfLCjZEAJRVkuxX7oroAJ00ejEce5Qqq+GeyfzJ3Xsxtisdw+YMIcm396UbvitkEqj2tjgQ2FHz2lx8JzwAuMSI08U8vKF1ObEdrmmWb7xGbh8O14PA/s3WjmqBESfo/BBubhsuKm1EeTPzhL4xS/ZoSNOmOlFDSPegDn1yQ7FF5OnnTLAe76Lgo8TnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmPF3g1C2iU5iMynpddENX2vnG5Q2jx/VxUe3BQjc4I=;
 b=saINiz+pE437GR36egGo3y17KkdkHiUMCEoC3OI53lUyMyR8erEfI7grG0f3Ua+X6za+ozgVTAIORCq5joU5E+5oNPdu4KXNnYW0d7EGrGYKgfVLKXp9MTUXCDbS4vJMBX5iXAewijZLPJdJlueVveBnRC6L+CFMEhfDNpEfopw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7840.namprd10.prod.outlook.com (2603:10b6:510:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:45:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:45:03 +0000
Message-ID: <fcc93c77-5188-4b1a-b780-b0d1762e2552@oracle.com>
Date: Tue, 16 Apr 2024 18:44:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/29] btrfs: fixup_tree_root_location rename ret to ret2
 and err to ret
From: Anand Jain <anand.jain@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b9fb4121b33c2b06ee0bcee74472c117481d2555.1710857863.git.anand.jain@oracle.com>
 <20240319182448.GM2982591@perftesting>
 <c124863b-9090-47e4-bd98-38a2e14e116d@oracle.com>
Content-Language: en-GB
Autocrypt: addr=anand.jain@oracle.com; keydata=
 xsFNBGQG2+MBEAC42714sRj0ptcjHWMJgkltgglCKCpcjdLTyoFY9dljqJdvrOeojl4N1Ztb
 qMwsnsoFkPiVMUnnU/FgypRlPOzaB4w0R9MTzfvpHKAUNMbaYLquldGJhfuYpTgikr5GztZU
 VGKGsKc4NJzWh6Mfqit2jwurS18RmjxR2dBDKKb5+M5xQ66M5Of2SuuzaM6UnT1vctDN/hWr
 MDqx3CNeQ8Va0i1iCStsdS3ExG6nBVZkL9ZCHHZHi/oqe4bG4vvevRlx57s+uS4WKpAsjlKD
 Z/WHxer9bffB9GuOCngrOTWiXtf1qmgXNs5kXlfb6O3uRv1xnfqTAHdxJ8/pwSShl2aDScdW
 7S265QZ92+ygEJeoviTc8FyrhKkV5c4hAMa9QeiuP6Sk7Mk1G0D/d/DlHQCncQZ/St6q5ESX
 M1LbFLp4amx2yELX0/2lLBXj5s0vQd4mbyz29K5TfiYB/BsEWzSA0gTM9MPdJL3FhIei5VsD
 SQ197dkp3pzqII7/rw77sQs6TFin555Q4DSMsKvKvm/vULpknXMe0DdrHw8ybrY2AjWiTs2W
 1Re7VPORkKxEK7prZ62hghiEvGyZHh0RpnI0aD57R8P3RLJ5P7mCMKimK46SC9fw+zWfWZJA
 EIDccuxTfaLdGPMO8GJ2HnKbvAFbI+nMoSYRvJ6ULvcsH9bPPwARAQABzTJBbmFuZCBTdXZl
 ZXIgSmFpbiAoT3JhY2xlKSA8YW5hbmQuamFpbkBvcmFjbGUuY29tPsLBmAQTAQgAQhYhBKPX
 ZMgfwKRZ10YTjD2+pVga3ljYBQJkBtvjAhsDBQkSzAMABQsJCAcCAyICAQYVCgkICwIEFgID
 AQIeBwIXgAAKCRA9vqVYGt5Y2EAVD/98XUcG+lHTLFvrBn/l+egW5BiJUiUuLIti9wMmj3lg
 Ndv6myanBwjK+v0+RZJ6Vr+oazwTiki6RgnxT3LN9u79T4C7vGuVjqZ205a1vGVN309oMPDm
 +rF4qstsNBMTyE6FfLD1n4ONqgMLATRuk5rPAyfIXQyKy5UomLZo+ISHjpDUt4sXnrsYMz/N
 Ht5w7LRQMmKva92T5cReAvyU8guCHTiG6oN3RCQKlyRmZnFCXa2ov+hYhBrpNikFtPOojGnQ
 JZ/i7RHIU7/ku0/NCGLe+3osdjxaItjkcLP6U7R+WrViweSKocwrtqVIlizSvaDv4MxYM2oM
 aHoAcolFcrpUaqgnUAjhwYRc6CNdB5MroTzrzGnacJ4y7xBlql0+HlrlNho2AVLqvXmar5fp
 uwUHYTeUwsixVHfJL+1sow3Ky7Q5SknDQKd7V7X9X1qs862fuuBD3iPLR4YY5SstF1P0lFrr
 QjNS85TaHFkFhKrXGvhe1WGhum5Fc0hVx88gQBZ2gdw8z4GWKC5esxbvv0lI2UhP89q2ClsY
 ZFS0/Odo0eGgfyxqUGtrouK4cMVXVP+LJb168xt6yOuPMTOLJH/CT9/b3LygcWxn4m/2+XbY
 w1aLKoaO1cKAMSObubp1nQIy+idTnQeY69oKQpxYp97EH7bhYBWfLp/kKJEB98hJeM7BTQRk
 BtvjARAA6w/uFi14uDJ1jAlGWYUpBELdj1NgSAWw6CR6GiS9XPlvtn1uApa80cy/Hm1mqYQJ
 FtC+H3Q0uJRZYol2dvDRJYfDmC4bwoO/mru8ZpHVF2c2rVehDvgzxYJeqH9fJi6fymr9rOa6
 tjX0v8FGKD2pnU8yPXsMNeADdl2lL+XPwVoVhAxx8bpotl8nG14TXQcBNuKxbU4oWRjUZif2
 32CAXkngOnE/dwo68L6tfwBaKNCtXXjv7BMXylXjByMciW1hsR+wwOObWioW8R9uQEDWSNv1
 EwXre7VnuIksrt53Ohfuz458eF5Lg6qKGMYYuLmNwRbFPBeZvx6989P2zKuQn3I6YxzA2sdo
 YIhwJHbJNsf971H3CMFORqiLZY9OQ3Ef6FaLW+KM0p9ezuT9bAomQm6xGJDWC93hM/xLXAd7
 LJxhhxj9rQTwSwxm5eQg0ODntYXeEVfJw/gW0eMf5ivTjzKEF22oTswsEKjnsaZ2UZNPi9Pj
 WbPTEWCzGe4jHLqgY70F7f+OgCoI6Qyvb4+UfXyKez+zuo05Q8TxSFa3diFP5/mRokFMzrmF
 lgnUIyPYrHJWAhizZQveSNQ/5M0C9cVykxhaGaF6r0z8JRxhXi0hAlFIDaGye1k+UB8ZoENq
 JVOcjH5uVcXjdqzEXCa9OCDCJrHYCTu+dxyvR6iFXZUAEQEAAcLBfAQYAQgAJhYhBKPXZMgf
 wKRZ10YTjD2+pVga3ljYBQJkBtvjAhsMBQkSzAMAAAoJED2+pVga3ljYwXIP/2B74x/gNE4c
 5/TGzX3oKEdflBGadVjkirOGM1yjIEqstnCF1UIABhyLJYv9IRaNzhx+ieBDD8knEVAAXvp+
 3b0cnmct+kyvOnXwYpCDJSZcJRE25f8fyTyvo17rUCdP8CennzfB0CFMeis7JhyC3b4ZRaLm
 M87gx9ZJA6z5SLarw5zeI5rHmpQ8FK4hGH82AJeedHKcE+RR8rNOyHpdKDHIEtTxWXTZAC+q
 TxCzgLS6y0OOXDGPifcHjSkW7mSrnVXb/FTIqxVC8ClHwSomp2IQLwqPaew+QNFT3RII7QbK
 vQyq+V0TMXGo7zQQ23SN1N08Nj7E6m/hHffFZvRJ1ibZdHaDDCeDXEZoklttj78325i8yV/C
 XDL6MeirxiJyB8P+Y9eSrIDTQP0jKBPQa6N66QeBSJnMFuDBbP82lovdszeCJq5XhwjDgQ3b
 zAKqel0LTK4JTAlKeYjX678eVUcDAkdfurkLDbYcPd6sOveHr1Wuz3aFgtPVVnVzg3rwi5oH
 rffHVDSAu23bB/YgL+OHJ+EzKIqR+qLaYt0Y+e12zhFBSazVC6NFFQY0A+BV7PPnOLdKF1IE
 kbRwSOU3mzvks433LMKj9vmt5TyRU99OsAIn/BY2nCP3FURwQ1NKQ2vpJ8KnkLCGePkjefcQ
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <c124863b-9090-47e4-bd98-38a2e14e116d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 748a7a78-2389-4904-66f6-08dc5e0245e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5o4XXWoF+yYOgoRA78orzzdayYZWWElqOnqJALcY06ioplu+2Kg8qM9aTS+gKwBrD14mPNcvvu5LU2z2I76RIMLxn5khkBJQeBNUcYL2yTWoYQ7dlXNcEwfJTbzhYkh98oBvE15nb8c/s3vKBkREkkK3Noj+twVkn95oY+Oxp6YyTytKwvhsKJhdZZY07qKl99XkVA+Xyd3a0/fc7LZ1wktJ2QlgAK25pLiPyNuWg5jp1VB2JnUkXFvtznXSRkch8q/iTpwgMbBlJKPSfV4+8oOEUML8aBjvla6X21ED4v/IvEJxuykVGLfcV84qoADYklLraYyaQVneZjOYVcKSdl5cMogpRXiZEbLJPVmQ3mAkMN49grQWG3k+LJjgWXOdUm8OZ1u7YB1by0KRbpPkBDuPZV8fs0quPHFE8Zrva3QNWZw9HX9QqqUKxAJrv81pcMmGYznYRA+SgjwiK8+dTsOm11j0ZeEK5C+Nm9Sq73pLnc/hK3/ZvtiqcfQCxM6z1p7QPvJ9C7Vu59N9jP/mGXkMS2qOvPWwuU8yQRwWqPuo4gVpkXXMbzIwaF2ahBtQEK2SZIbLP0zP8WOazLeJkDbpN6NesIoDKu6CI2Nz37wQEgvsUkhL+W5ZnD15ElKSiLIthURfbpwJEIMinKn5OAnCC+W89ZQCuzvXk62tB0U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFJNVUxsL2ZoQW10c3p0ckdFQkYvcVZDUDJjdkR5eTdIMS9rQVdabmtQdy9v?=
 =?utf-8?B?RFBoUzY5L2k3TS9kTWIzbzZmTXFTcnlzVXhGZHVOaEhkZVkrTjgvMUFBR1FU?=
 =?utf-8?B?NzdCM1czZFIzZnRpZUdKcG5ZbStrYWZzeDhtUlc5a1hxcXE2b2NGRk5oYm9S?=
 =?utf-8?B?Z3ovdXRnYmdoK2lBNm40dEhDb3FlNkxmbDRFNGROTlU3eWg0cDk0ZDg5NmMv?=
 =?utf-8?B?REJlSUgyeW1icXhrcTZYUnB0LzdmQXAwakMrUXYzL3BhSHpwUGl6NGl0aktD?=
 =?utf-8?B?aFBma0xPN2ZsTXJHc2dudWRvMys1eFprQjBwM2JQR1paaUo0eEVoRlNLOE5Z?=
 =?utf-8?B?MC9hOGxCMzk2MnM3c0V3eVB0YlFvRGtXWkJmOG82UXRLdDVuVFVtaXNLd0tR?=
 =?utf-8?B?S1FFYjhKOWVUQkNrSjNjSTFnejI2SGlaTDU2Z3F3MkNUS3RJRG10SjYyeUQ2?=
 =?utf-8?B?R2l0ZHk4SjRmenNHcE93Si94bEtMVTVWYmFnVnk3a3laWUFUSi9HL0s3MUV6?=
 =?utf-8?B?M0VmVTJDbDEzNHJCYjRjS1hpMUprYXJ5QVgveFh2UENvUENUWHhQSTJaanBD?=
 =?utf-8?B?QmllTTJlQjQyOTlFWElNeTVha1BOb0JiV1pLTWRhVWRKOHBrWDB4Mlpzdi9n?=
 =?utf-8?B?YjZYNExZV2xIQUp4NThzYWlzWGpYZFU5bFY3SW9HMi9WUm03NUVkZ1FKQ1Ri?=
 =?utf-8?B?Mm5ETGduYjg1LzJ6N0FtQ2djc3k3T2Ewek9wdlQydXIza0RzUWZodGhGVTRh?=
 =?utf-8?B?S3ZDNTFsZjYzQTFGeVJvSndpUjhCcHF5RVRid3lNdmJ1VnRXNjd0NzE3Y1hZ?=
 =?utf-8?B?NFpJd0FFV3JlQVU4SWwxUUx3aXZUeE1seWU2NzZyTWRFYTl5Q2tLSnU2SCty?=
 =?utf-8?B?Q3VDdUYxNEZ5Z3V6VXdQY25FNmZ6TzJKZ0dQeUVIQjVUL3MzMUJHU3cwcGM0?=
 =?utf-8?B?d1IzWEo3M0ZvMUdZSkF6MGFlckJxUjlFN3lXTk4rSFJRVWtwOHgyeU1FSnJP?=
 =?utf-8?B?OHYvUDI4aEgyQ2NLZ2VENExNbzVLYVZDb3dVMUk4dHFXQkNsNUV5ckNaUTJ1?=
 =?utf-8?B?aGFLT0ZYRmh1MG5CZXFUQnZOMVBNOHR5a3VmNllaQ0pDMXNQSllDbWlZRlFv?=
 =?utf-8?B?SndVSnBVZTlsQVp2UUVaazhUK2RiRDk4dkNvR3EraG45enJlVE51L1JWeFor?=
 =?utf-8?B?bENhK054TmpiZnpYdE9oL3BSeHdLS0kwNGhWTkFicGs3OGpYcFF4aHNjNktB?=
 =?utf-8?B?YUpKTWZWRkZHY0NYaDRYNDlkRmVDaWZRK0VMVXdIdm5jSDkzMFhieWc2S0ts?=
 =?utf-8?B?NHQzckthNnNxZzBtZjhrWWM2MFRtaytmczZ5d0J1aEU5T2ZYU0RKcVZKK0Zh?=
 =?utf-8?B?dGFnMi9lNG9EK2lRQTk4VTFXdnQwdUxYWDl2dEFScTg5M1ZzYTZkOHlrMUto?=
 =?utf-8?B?dk9qbXFYdzZJMlVWNkFyaGtpVmVzMzUzMllLb2I3d1NUQmRHYzNnSWRlWUEz?=
 =?utf-8?B?WDhEYzNiejhDOHZWYWY3TUtPSnR0NXgxRjR0QkxEYzRMdGZGQldpWEtWYkdB?=
 =?utf-8?B?My9mZEx6Z2dEdHlxL1UwR2xza3A4UjdUZEFWeVhld3V6WlVBWnJXN1l6SFRP?=
 =?utf-8?B?M2cwSmZVOHFodWxvNUlvSnExZENqV2pwRGtuQWhiUEZqNWpnb09tc0FCdnNa?=
 =?utf-8?B?T2IyWUhEWWlGcTJqcitMVFJ0cW1ncGxXNU1xTnlybHVyakZlak1DQTBBa1VB?=
 =?utf-8?B?T0FWSHBNRlNnT1VpYlp5d3Vhb09HSStoblNYT2tRc2VidTFwdVZGTmx5MDRJ?=
 =?utf-8?B?WllxUjFjRGdCc1Rvcnd3NzhiZmRNNjhnVmNIVmNRRTROd1VFaHB0WGhjVHhV?=
 =?utf-8?B?YjJEVHJ3S0JNS1RKT0M1aWI4ektDRDRNZnQyV1NvQzhmbWxBbW4zOWNLNnJ5?=
 =?utf-8?B?OXIvZmdZV2FLVFVGaXJqdG1uR2hFYmk2VTV4NUdhT1BIa0dreFpaL0kyVlNM?=
 =?utf-8?B?aVNQcFFUdTVDNEF4Ui9QMXErZVAzNTNLR0p1cUJZL0VzcUE4dS8vaVRURk0y?=
 =?utf-8?B?STg2Q0ZxZE1NN0lmRzV3WGM0YW5NNlZCVGx6RUtTUDdNbnRubU0wN01GYmw0?=
 =?utf-8?Q?6QllI2Nyivpxy5ae0W/dkOSoR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ly2jeXSeB7XpDuiGXoJswj1miPC2lQ5oNJhbtR91+CgVJPL5CiXSbuIuwvDk5XLiBBOudflIeHLhrk2m8PzTBWuiTuAE9BaCwVoT6b4o4l2tclWO0bFyf3CUpehSXSJ2p42oRAaMnKE8zN3p1lyzBfbPb1Hr31fLl4dBsuyJ7ZWEok/8KhQpByKL4vjO3NFXuX38ccAGSx4Aj0zmzlnC2HTBplyxNb0/p/2zLpSTW4MjQj6qnJpZOnTVpiBevjDb3XadWx2CXqiuv3+C6SDvyxESMxAbyD77MraMb+RYTypSP6z7hPAHVrsGeXMBQmSocrfq2p59tk4MHfLRkl+0Qqmy+NCW7ZeNRvOrvW5xD7wtddzPvofijhXE3AxMasTHvuWzoxHs88lu98xV4FRHaxGQMCqLh8TenQSbnWt//rntG5TJR/RGDYVAuiiB2UnVfDyrEtNaW60nruNUg2lPabBFJtowylo/HbuH57V+ZAjNmasHPKAI+aZehFQHMQEhg9mn59GIdrBk3Xhq5iRSlAywkidYtp22yL+gCtVAn86iwQXUTtivNiPLSdCs4CqJTiVCGOLpQv53C1B4Hg7JmgOIwJrrf/zx7GuUMYyESJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748a7a78-2389-4904-66f6-08dc5e0245e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:45:03.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ycpf2iShDuIFhzQuVENqx0l8ccaoO4oVV8fxNwkg2oHYSLNpgYnqGt5uYXdC0njvRI6k8tGF4OD1PEmXbQOFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160066
X-Proofpoint-ORIG-GUID: wbTtkBua-KWtXS02v_1yysPjFBCNqmbL
X-Proofpoint-GUID: wbTtkBua-KWtXS02v_1yysPjFBCNqmbL



On 4/16/24 18:42, Anand Jain wrote:
> On 3/20/24 02:24, Josef Bacik wrote:
>> On Tue, Mar 19, 2024 at 08:25:37PM +0530, Anand Jain wrote:
>>> Fix the code style for the return variable. First, rename ret to ret2,
>>> compile it, and then rename err to ret. This helps confirm that there 
>>> are
>>> no instances of the old ret not renamed to ret2.
>>>
>>> Also, there is an opportunity to drop the initialization of ret to 0,
>>> with the first use of ret2 replaced with ret. However, due to the 
>>> confusing
>>> git-diff, I refrain from doing that as of now.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/inode.c | 32 ++++++++++++++++----------------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 952c92e6dfcf..d890cb5ab548 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -5443,29 +5443,29 @@ static int fixup_tree_root_location(struct 
>>> btrfs_fs_info *fs_info,
>>>       struct btrfs_root_ref *ref;
>>>       struct extent_buffer *leaf;
>>>       struct btrfs_key key;
>>> -    int ret;
>>> -    int err = 0;
>>> +    int ret2;
>>> +    int ret = 0;
>>>       struct fscrypt_name fname;
>>> -    ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 
>>> 0, &fname);
>>> -    if (ret)
>>> -        return ret;
>>> +    ret2 = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 
>>> 0, &fname);
>>> +    if (ret2)
>>> +        return ret2;
>>>       path = btrfs_alloc_path();
>>>       if (!path) {
>>> -        err = -ENOMEM;
>>> +        ret = -ENOMEM;
>>>           goto out;
>>>       }
>>> -    err = -ENOENT;
>>> +    ret = -ENOENT;
>>>       key.objectid = dir->root->root_key.objectid;
>>>       key.type = BTRFS_ROOT_REF_KEY;
>>>       key.offset = location->objectid;
>>> -    ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 
>>> 0);
>>> -    if (ret) {
>>> -        if (ret < 0)
>>> -            err = ret;
>>> +    ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 
>>> 0, 0);
>>> +    if (ret2) {
>>> +        if (ret2 < 0)
>>> +            ret = ret2;
>>>           goto out;
>>>       }
>>
>> This is another place where we can simply remove the ret2, just do
>>
>> ret = btrfs_search_slot();
>> if (ret) {
>>     if (ret > 0)
>>         ret = 0;
> 
> Original code returned -ENOENT if btrfs_search_slot() return is > 0.
> I will retain it (instead of 0 as you suggested), I think it is correct.
> 
> Thanks, Anand
> 
>>     goto out;
>> }
>>
>>> @@ -5475,16 +5475,16 @@ static int fixup_tree_root_location(struct 
>>> btrfs_fs_info *fs_info,
>>>           btrfs_root_ref_name_len(leaf, ref) != fname.disk_name.len)
>>>           goto out;
>>> -    ret = memcmp_extent_buffer(leaf, fname.disk_name.name,
>>> +    ret2 = memcmp_extent_buffer(leaf, fname.disk_name.name,
>>>                      (unsigned long)(ref + 1), fname.disk_name.len);
>>> -    if (ret)
>>> +    if (ret2)
>>>           goto out;
>>
>> And here simply do
>>
>> if (ret) {
>>     ret = 0;
>>     goto out;
>> }
>>

And here as well, if the name doesn't match, we returned -ENOENT
in the original code.

Thanks, Anand


>> Thanks,
>>
>> Josef
> 

