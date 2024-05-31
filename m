Return-Path: <linux-btrfs+bounces-5374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA108D5D59
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E917B28CEB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4C74E3D;
	Fri, 31 May 2024 08:58:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65F1171C
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145902; cv=fail; b=XXVR/uFpZB5YnYSdt3ZBBr2Jj5DdCRMHsxOvj2YQy/jLLwCjVPyoi7KKcLizVHJ869Uk9eP61vHXlfBsimjaX/l8vO5VILnFKrQAmv39thbXjwdtPfpSQY/iCiDZwIPIHPu5VRuHvIs/qgN6taNKyLKg+KHY58Ai/P1RIYM7/9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145902; c=relaxed/simple;
	bh=21nrouruRdnLo31foRXHpSYD3zhheqwlxwJZ8beUDb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gk1Biy4JlPuvikP7qJb1J6XCJZFZ7G7guGG7zJM8f98yRmMV4w0shKHWQjJBS7s6wcAUWuoqlEFXMlGXF4YGBJ7YIDv6/w8Iwqme2TvE73iX+OJ6FdrZU1lAXZ1U7G/h1TOjyunmWV7pr8QKEZG3F4iOls7Dkb7xK5rV7flx5gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V464n1004472;
	Fri, 31 May 2024 08:58:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D21nrouruRdnLo31foRXHpSYD3zhheqwlxwJZ8beUDb8=3D;_b?=
 =?UTF-8?Q?=3DmXoREhx5v31KthFot/ObYMAjxNMJG/yibTeFQf8B8oIqu3JFWA1kXl01dK8k?=
 =?UTF-8?Q?2eeduvnq_C+Rj1frT36ngoa5TpiTz9gZL1qeJrATAf2cgk4+83L6MfLplnhe9Kc?=
 =?UTF-8?Q?ZIwzr4zCLtbHUA_GTrBWYI3nBEqvP/Z+1ODUqgbiZb21HcoU9U8CxNYsRaRaTty?=
 =?UTF-8?Q?KsIEyto7KDPL/5Ljm5Q0_7LHmgjKShCR5M7YwMUxatSvFLyRSg42yDdltxdb0Z9?=
 =?UTF-8?Q?wduHtX0a/RZ5apqp+vH/7eUyYM_8OHNGdA/I5usjZTdOYWNe5uF6QOjoQ8HHAua?=
 =?UTF-8?Q?R35LU9rh9ZtkQahkMCWPngFSqw0jm0M/_Qg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hgary7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 08:58:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V71ndM010637;
	Fri, 31 May 2024 08:58:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc511pscb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 08:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+iwEqDr6JipLuFGkkhABzf8tuQIKJohC+Qq5KSr1pUdN3pzko+0kMJw56J8ZPbBBjl45pBxtDfcdoV1LBv53cctMHnsForL8hzlZ7cqCDDT4iK2XuuM6a/5H/MYj01018FoJoZxiCaVB7p+zlr4KBpwdXtLz8p0l+RcsIDbg0U8VljDbBub5yLmx1CuC5kK5QwVa85MzHGazTPo46qCWybMXlgBVesGN8KFIX38dWsBqZq+L+j/goSn3QE7GR3l34B8HrylGSuJUfDqGwIHJSHvPjegPgqFSrBHFTtH0wuc8k9uma7VY6oiYt3iTqb2DgitRwbkNQSVPPmmJvElaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21nrouruRdnLo31foRXHpSYD3zhheqwlxwJZ8beUDb8=;
 b=cQ+nlU0QBHvvlSvTFlUzYiuDGnnI0kl717de4zeT6yjJrtxhGnc6p7DYopkxwtLw3s+A6grxxBqHNaVkCP4QgiyCyM4B2AOT5T6KgEfoE/eHo5JkR5yhWtS5qpuaTVd8AqDQnhraDcTnWki/uwW5kUEcS870Xdx9mlJg6A2f7MYRyMakGWpaPc8ijUE8vlbHvIULfDbbJrXv12/VbXxetgHY+Pw9oU43e2sDXuG6bE4WBWZvvBV70hiVmTTo0JKuOf0bktnxM71xoaazbKJk1CSEZD837tV/Q4FMAWUU/ZkJTyrZuwhauzHyLaAx2j24MwMeCx+RJSOt96gtaSpl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21nrouruRdnLo31foRXHpSYD3zhheqwlxwJZ8beUDb8=;
 b=sQiNQCOxJZSK8tPz+nJPyK3pnGOOuM6aWPhCwYwlfGU5k+kdmfnc3GdNqiEbsoN6zK1k+0sP96iUyXBT0L2qYpAiZDZMlazVJVLaDyYS7jtPkpvmBKQnp75hGuJwrQoGFfv37YC1uND8KYrMhF0y/EN8kp5TAvywABW6zSVM6Bc=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 08:58:08 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 08:58:08 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Anand Jain
	<anand.jain@oracle.com>
Subject: RE: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Thread-Topic: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Thread-Index: AQHasrlKbLlLTky0U0i/yX28Adrz+bGxB0+Q
Date: Fri, 31 May 2024 08:58:08 +0000
Message-ID: 
 <DM6PR10MB43474C588F4C4002C673BE78A0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <20240530174625.GD25460@twin.jikos.cz>
In-Reply-To: <20240530174625.GD25460@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|MW6PR10MB7614:EE_
x-ms-office365-filtering-correlation-id: 0da4b414-35ee-4eac-ad7e-08dc814fcaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?/6nlPvQsxVdxAumzEbxlgSn08rGdi4ZWFATCUG+dhJgZvxETtJlwa38645Nw?=
 =?us-ascii?Q?qZzEDBTxvta+LE6jGGoXymTki2iOO4EZAEbmS6QvKnzQjTjykQP1F3U41lEt?=
 =?us-ascii?Q?erPc40DdhESACd4FOt/S8UD0o25xTAeZyIe5nFp56sgl00tzQ4mXLRM6ygzu?=
 =?us-ascii?Q?xN7/y36N1e6g04COLdPPS9rt3aN6xsBYlU57tmzVfHlGLINXd2Anww/3JuyO?=
 =?us-ascii?Q?hAAgHuwKq7X5PYaZ6fcfNW7bN+ZcPEhQr2Rb/JlUEs6XVk70y8VrSAWYf7HM?=
 =?us-ascii?Q?Ef+gENCWxTJIuiRFAlcZlZukFMn+cdosJtNIiLYv0K6hBkRXFbX2//rTV/vr?=
 =?us-ascii?Q?8Qjetu6OQnsJ1rGBiRBook2nFYMiq2Fgp2am2hF9KNU3x+GEuuZWg6O/fCzs?=
 =?us-ascii?Q?w9U57/Kpa8fZf/bSSA+S/adQKlSu677KcYC3bzApF8f0UVES40T6S1B+owF4?=
 =?us-ascii?Q?tlH5FgamkUBqJJz2ZXYeJFpXcBYqMIVKh+qUPcZUNb2ovCMxBwUJ7192hG9s?=
 =?us-ascii?Q?i9+kqPWYK+HBsNMWPjKLIYrgOVshrAqlRbk4p40t/W+YKjzO2+3bISNStEfy?=
 =?us-ascii?Q?CFVHWKRwHelf24DMrdLChl2R7ynsnItRajV60kn0Wmw4ZLQMEF0GVJzgifjS?=
 =?us-ascii?Q?UPFB8b/UYIzNsaGF7A13LCxYqGpemb5sBDPmVBB+/57yMLPs5bpVXHCAy3Fb?=
 =?us-ascii?Q?HcEBFiZaHm4VUmxnICXtcdkmBqvRRMBpZjm8XJAFEjUC+kfKvn2hNPsR4NwU?=
 =?us-ascii?Q?J3pgJ3gixk6vX+vSpFX35d4PMkhPmd9wHokRFf1+3ZN9a9BRhSZt58CFs20L?=
 =?us-ascii?Q?HUST3nLTvHpgy5pywjNfccjDvWcNkjWn48OJ52ZellXcpbfsC9yfMuzvqFwo?=
 =?us-ascii?Q?RyYwrNqUEpsF/ZhzIADl/O6f2Yn/eO3NJEx5ZKv5K3GU+06rQX4ofzlduqSG?=
 =?us-ascii?Q?JevTGaodaRmjG5nWjm1qXSn+7iurig8dIpuItBRjrDKG56Bp069WPh6HMJKc?=
 =?us-ascii?Q?qhVLR58Lb9yOBs7w2j6ufD+z3CYyqPJqFqHGZMCu3q4OtAlXdRgldC26+7em?=
 =?us-ascii?Q?Nhfr4S2ag4xrjZdE+/fOTUVrggUdpDHOfzNu03mKWi+dxlydNelA/P0Im61V?=
 =?us-ascii?Q?p7QGk9WfIt9Br5j9C4W5lC/royroEKmioX7DPvr/ROGiTUAvqNSM/WCiDr8i?=
 =?us-ascii?Q?CjzYtqNnHyWSBXX3vGZdk/baW0+jzRhkmDUwKHu7ukRuicT8blCbs0hyNCJw?=
 =?us-ascii?Q?0bAghIfFNSKpBWHivaWZlE6nQlOoj+/Ak/+mjw8TCN4w0LK/v9/zlrRB366U?=
 =?us-ascii?Q?OGr0Qm0+nsS8wMqafbDAQDJgMO3sq4KYgMeUD8kxNY3fmg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?oqI9slSTmkDvK0UzpINut0du3RFyycCjENYovfWrxYrnV2HURgML/Vnvnwdz?=
 =?us-ascii?Q?O3Fnjjr2aoRaCxaK0DldfL0BX7cWoMXGJGKAdXWKFlFp9IFAJV3Oq1rUHHK+?=
 =?us-ascii?Q?5dhenSqZprNJY4JjnGoWdpIfluI1vCe3c8g4eIW5Ntn80j8vKvVypPoXZSrq?=
 =?us-ascii?Q?DHjoUtPfyM1kzZaCWpYe4CxJEf3i2z6s70aq9vWHFs8Fdj+2/TfDmqU1TcR7?=
 =?us-ascii?Q?4dvMH0oZ5bKTDkn9bBoLyFy4ejVEVIwpzMTXeX5xKG/GTv7ob7oYRrFyFklG?=
 =?us-ascii?Q?CYByfbNPep2OFd1dqd8MwWa2B2LhxDtVPYjFIBUCVxJ1TN8hjsaUCWQ8ae89?=
 =?us-ascii?Q?wcaLTeiJ1dJoB97GGLxPq3tzBTrmvUnWZYZxW0QnEfeEyWSIN5FCrbbfiQKP?=
 =?us-ascii?Q?jz4jU65CBxwbt5fYESr+qbdiaFV13lvnmWLmRYLrtkWNhrujr+uPiToodBAN?=
 =?us-ascii?Q?1QCrz5f/Z82Nf1SM2lW/jJ2ltD74a7lvwQgAc9fVh38XXnzZwF0A1uoOrivc?=
 =?us-ascii?Q?vJmKhHyYUjHSJPHDl53Cu2TBBX2S0TzUlKIHQUlTjy0otYOTevjtMDM8ffIB?=
 =?us-ascii?Q?kC52C/gJEIXPPNvwFvQR8XIDYSStrMRsPiimudCs2aEQ9bTwT4IEOoCeTSl+?=
 =?us-ascii?Q?q0yaX246ERmZQuhpptT92BmuIHgP6c1pylSGiZq2JQyny9NrXkfBX27ajaz5?=
 =?us-ascii?Q?joAkZpEfdMWopbCEbqcWKzTl3HIHio8BfuOXhck+6PlBWtyBDow12AGAdGGQ?=
 =?us-ascii?Q?C7EbkZwBiChSgyXfXcsxLD8lnTeJ6HQ2ALnR4XGwJT+NzvvUcU7i32wMr/ef?=
 =?us-ascii?Q?tuMEzrogSipUfp1rTBzSjadDaXGz/UteFOu/6hnq3L7+cDhAM9+cqb24bpyi?=
 =?us-ascii?Q?VFrLV61lXDakMUb3VrRuL+FTIShAnv8Jgi+uDsRchd7fOa0yL1fiusmD98lT?=
 =?us-ascii?Q?vM7F3Is6rHEIXFbvuw+PbVA7P06fqshnyc1JIxwVNwuvN0t0Ww0/rAEfwbVX?=
 =?us-ascii?Q?6pwCMmljryVzTknXElo0hB9ejQyKmJNbLs0BtFzyK3Xpymn451jKl8FTFw2X?=
 =?us-ascii?Q?pQNXnD5sJi6JUxIPPrXuHKi65OF8IKKsnumtvZw/dbJ4f2CfjJyvPw35ezNQ?=
 =?us-ascii?Q?+4FVEtLqoZu9F00cb0JZMHetUOBJ9ZHnxU1poKv+mlmVp3N4OrgZoFA4QN1t?=
 =?us-ascii?Q?i1N4/AEUC+8u6HXcW0oh639OXWJWtHJiEk2Qbn+qn7YaC1ihufQIQwOFZJ9X?=
 =?us-ascii?Q?HiGUbA/Hl6LJDaQiQkZSQYRabd2K+6aa30oHp6tMnqDVCYXOLsXu/1XNkklr?=
 =?us-ascii?Q?hDTwffISOOuohZVt6meHMWlVLMdkS6KpBFmFV2Z3xvnd98XakwWKWAEehWxH?=
 =?us-ascii?Q?p+0xEDSMMvlKglo5LlBj1/gcH+Kj+UweYHh5Rklg+Z2wkFdbIXW+ELYAVaMQ?=
 =?us-ascii?Q?9S1G3QWf82IDFQVmKw8MCguyjdCH55sESoAP/0mQ2mlq5N4/hcKPNXDpAHlv?=
 =?us-ascii?Q?u8iaO3EBMR3pUU1ZPn+PJBZlgf9ay9nDPhGTV6LhIRjb4nySBJMqY/FLzPIr?=
 =?us-ascii?Q?b997Y36UdYGQB+zgMJ73aD81usHGtD6cEVotr+7m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YWmrKu9ujM4p08I2Oa26WhEZXKIT5OPk4rxRpDjpqFDTj/SICj2FOsOptnXblmfjXgxtKH9JuGKLQExj7fplFvG97CxSkzoKQoYZ89gcB7J1bYvRbxoX3zsRxkfbww/GfgVjoO3FGeWp3Gq6F21p3ZW9czm3OnPu5s2YQ0exQOpuCTdfVYpmh09ZGr9TEneLw5gVq5QKQG8nAztqW11mI2DIMMIVFgxxJ2MnzFbsnZjppIsniYynS436OCUgeOMsA1icKlEjLDygQp8V76QQC7SlocvpsXfnuY3On+78l7ezfyYnNs0QJFcJwkkz94Ug8iaIU+eLTPJGUc94/Nu4I+A3g3laj+A/dFI+Y2UwCH6+L2llaWSftC73do0EbuTMC51fhxFDqFOTYaWmtuDHH49RYWFIpSmILB0gBtFpK+u/eGBFZm9lUf4k3d1Kt6G7TtERh1noig/B3M0wzBom/RlVvjivIzgAuu2FOadoNKBEGRqKet0QOnn3eJZXEi3swXMA8B4jT1tPnUUL1El9IlfaNcMwPX5/sOVPipU0cjclXqYQKofFFQTf9uYm4uDllyJHIBniYt3iO+ecscWpuOuF/j9IDEY+v7uth0eSgww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da4b414-35ee-4eac-ad7e-08dc814fcaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 08:58:08.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPSxhr2uzHXpUw0dQlUqJeOLFCDt2OphQ6agCOPWDXcKNI0GirGd7rHtE7laGyOyrBtSmUUWRHtx/iugcbUxX8mm1zPdZiArnsTOHu/89lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310066
X-Proofpoint-GUID: ktogaJAw7kimGtijSd6iZOut76hyDrPc
X-Proofpoint-ORIG-GUID: ktogaJAw7kimGtijSd6iZOut76hyDrPc



-----Original Message-----
From: David Sterba <dsterba@suse.cz>=20
Sent: Thursday, May 30, 2024 11:16 PM
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaram=
asubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com; j=
osef@toxicpanda.com; dsterba@suse.com
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers =
support

Hi David,
Thanks for answering Anand's question on my behalf.

> On Thu, May 30, 2024 at 05:37:54AM +0000, Srivathsa Dara wrote:
> > In ext4, number of blocks can be greater than 2>32. Therefore, if=20
> > btrfs-convert is used on filesystems greater than or equal to 16TiB=20
> > (Staring from 16TiB, number of blocks overflow 32 bits), it fails to=20
> > convert.
> >=20
> > Example:
> >=20
> > Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem=
.
> >=20
> > [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1 btrfs-convert=20
> > from btrfs-progs v5.15.1
> >=20
> > convert/main.c:1164: do_convert: Assertion `cctx.total_bytes !=3D 0`=20
> > failed, value 0 btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> > btrfs-convert(main+0x258)[0xaaaaba44d278]
> > /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> > btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> > Aborted (core dumped)
> >=20
> > Fix it by considering 64 bit block numbers.
> >=20
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
>
> The current conver tests passed, can you please also send test case for t=
his fix? Thanks.

Sure, would you like me to send that in v2 or as a separate patch?

