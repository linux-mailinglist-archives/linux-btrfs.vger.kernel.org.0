Return-Path: <linux-btrfs+bounces-2273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C676584F1F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 10:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF391C240B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738866B52;
	Fri,  9 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Aul1tNoZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0BZqDdsq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36265BDE
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469582; cv=fail; b=q2Bgv1KblmiMOH7oesIv/1hOmRiYXax3fCvUEVqDb8oU8ZcWeaV1/I1/IoKrjOO63U+R2mLYVRjmU9QtSo3Ufj65WbnqG8ixHenxP6zr3oeCV464XpG1J/v7Va9eI/hZTqOfMf4NLbv8p0jejRfhQE6e3L87Ew6JRik+RycfGkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469582; c=relaxed/simple;
	bh=cf87O65AJ7c4Q1/RdY22tn8lXSwkH0EZ+F5i2ia7Eco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVkgFn+x5cQvoLljDzKrbnR2kI1W7FIDK2jS0elYXvolPyHqBcYcXFHsl4r0OaT1OTtcKSRp5Uh5KQ59WPHGOFrFI07Lcv/c1h+hBuiIIsS1oMRhxYWAeviSPTTSlwKysX7kjk4xsSUom1V68Yt1LFDSghWa4nPscACSlzHRpSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Aul1tNoZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0BZqDdsq; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707469580; x=1739005580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cf87O65AJ7c4Q1/RdY22tn8lXSwkH0EZ+F5i2ia7Eco=;
  b=Aul1tNoZBnS7+SZXyygCO1iQjtEQA0rbnLDIKSG4TofVwZsyFlpkWVFJ
   +nfntG6Rmvbj8OI5EAGG7WufQjqqLW97QFcWWYVS4fDP46Tu6xa5VfXg0
   8WwYS6LPj3hywNcj6C5PYnhzpch55U70gvg2acnatkfi2m4U5vurq5UdG
   eBVDDU8WoMmI/WVo3r4Cs3XERfnhxjECwvLV+TNG62AaDxHdZCDW2+Bcv
   d2yB7IFOD8cHDYJPZOp6SK4powHgfFjbAW58Aq5yfk5vNOeVaAQ+20aDe
   1gT1dn/WhvxhVbTvotOf/Pt6UQUc9bvRCWLHvLc8eUmJVBm48NRVGuBJW
   w==;
X-CSE-ConnectionGUID: dryagBDLS76ZG5Xj5YaGhw==
X-CSE-MsgGUID: tq/1e/EaTtuDduaMCQvENA==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="8935774"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 17:06:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG+xs/GA+fxXC3sJTCLQqO5kvEkzZDVHLTwiFy9mG7bkWGhiY7aVjhA5ZyHblgjHwEqOnCFm3YGxFZsV38/n8LMVNIX9djfrxi/dqjz+uZNFkQFT6lRSYH0mOUtuJ0DClzZb6fQhFz53XymfsWfBlmwNBnoYs5kgGyW0Ucrt94AhFWKsbZ1bWlQszLwEMYCP4bRWb+TyXsErgEJMYgBtGMqKXoJ5SxhRn5TcdMP7GHWLWBqslG2zJac7R+CMktczvbeksiSILWqshmMj89M/y9GbKOYtIDq7/U3uUGc8ekVMVtg4LiiXSBftapZtjTDuasdhzz6xABgEqvpa2ulAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf87O65AJ7c4Q1/RdY22tn8lXSwkH0EZ+F5i2ia7Eco=;
 b=j6W6NYMMH+THCbtwzXZ1YD6t9W2XTiJwBZdAI9K6Q4sgGts92cFe9yLkW/g0+dWN0MkpG2KvDldbnzbwuAz6+161LQkV4wQqDHRb8uCAm07CTuOwigczHHi+Mn4Mj62aYgn9L1GN988NCZI5qoLQs6fG4Sh2/DxORpaIUXiK36NxmcPwrywzOcdI4sjHWF1155W4J3QkdofQqdEh42zOKgiy3uhtn/L/bi6H3spjmqEk8v2Uu33MPQAcQSOTFBoJuXrBJslx8OzR8Fhf5ThCSWhOxeEww4qdZaOrjmMaHmJArSB2ZtIv7ANKeBXQAulwrFvfeVpO0sgTXIhmq5+rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf87O65AJ7c4Q1/RdY22tn8lXSwkH0EZ+F5i2ia7Eco=;
 b=0BZqDdsqckH+q096I4FapKrZL4K8YUzto8n95iknfZYqedI9e3P7DwvgjNYJ945Rtt4Dnfhmj2zbkHGLRwxcZlDoBIK8tLDw9tf+J6Lnm/eloldB3dSPGWm5U4wGfLPqlX9CvE1Rel12ywkM0ZXS7SnlbiwqmOXD/vIQ1HLMCSE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7203.namprd04.prod.outlook.com (2603:10b6:303:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 09:06:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:06:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Topic: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Index:
 AQHaVbCKj/f1FqvKZ0SR7X1wPPWj1bD2+NkAgAFwV4CAAMh/gIAAvbwAgAFL4wCAABdUAIAAE6IAgAUG+gCAAUgDAIAADC2AgAABoAA=
Date: Fri, 9 Feb 2024 09:06:09 +0000
Message-ID: <d3b8ff0b-0f76-40c3-aa01-f5a9bc405512@wdc.com>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
 <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
In-Reply-To: <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: d9f9cfa4-ad78-4004-0411-08dc294e5b2a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TK55oU/BsBcFyFJ6lm5C2xUGTO8Qqel2D7aLuvWZ7IZ1ygt6COvivxCSDGBaP3HoJrOox9kDhwYZiJzNdIUvbNX9gWL6LMezfP+mvTZGW3SYcRuZwxjR6JceIppZA8FYkhbEVwLy8c43/1XHc5ZzHUGLdMrIxsEXTwU2eysjPohASeNsKruBDMMY3TJ70vvZvqsSGE98B7wAVnJaovzIlIwbdZhGznv2qekO8gtC5JQYC7sfXH3uY/wq6GmhMfTgoTZsEFLSvuYU1oXJFaLPHpKh+kY0C07h0mmsK2sB+cT+NdEofmPqTk30Pftw0Rsbraqe6pt08OwK6YJFqnwX3CpmrT/kjGkNafOy63Dc/FCfJwcHPvlUg6TFcCVd4cBXlZgk2BfmLYFdujs1swq0RhsyQ8AxU7o2Wy0vC0ToZyPfvlDW9rsZfGV3Jaf+iRSqEqdUYyHvVg0f8iRaanLKVHPhLGyZRITa0cEdgPzHShaRcgf5O9Gsb610q7rxd80mJbW/FVIl042x7OIWRYSHxzVj0ytMOt30XB4L15EVoP5mwkmqHym5sXdJuvY50dL+ukHJ+UoykESDJ1CnYHH6igI+4RLtWb4vnLoXYWv0/Xw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(2906002)(4326008)(8676002)(5660300002)(2616005)(83380400001)(38100700002)(36756003)(122000001)(31696002)(86362001)(82960400001)(66476007)(6506007)(66556008)(76116006)(66446008)(110136005)(38070700009)(316002)(66946007)(64756008)(53546011)(71200400001)(6486002)(966005)(478600001)(31686004)(6512007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm1yY2EvV0FNRG5yY0NRMGJ2bm53dGZFS285QkJpTVcybnVKSnJGZVJPdmVv?=
 =?utf-8?B?N3piUk1YbDJZQS83RVFDc3FLRzdXVEliWmplVHErYWI3YUUzV0lUamxmcFZo?=
 =?utf-8?B?L1A0aGNCUVBLQnFXbldtZDRSdmFWVkZJUk9YaXpqdzBCTkViRm9PeGplMGxy?=
 =?utf-8?B?NG5RUjJEeEh3RXk5MUhXNWtqVU05Y0lRMXl5dlFSL1ZiS3FVdFdSaEFYZkpN?=
 =?utf-8?B?L3JlMEFWV3IwV0pRQ3E0aUV0WExpdTBhUEgxZnFzUUx4ZlRLdmtXVnZ5NHhX?=
 =?utf-8?B?QzZHdkloNkpzbVBFeG5UMEVOSStHWFVwbEZ2a0lqTTdqS0g2QUoxY0pGYkJj?=
 =?utf-8?B?ZGNIeno5UjVMY2xtNjEyay9Tby9aL0xWeG5OQzkzKzlMeEdBSFd2Wm5kQmxs?=
 =?utf-8?B?aVBRTlI5eHYwdUEwSXRlOTNzNDhSdTJoVjc3YVhsWEg4UkxoUG4zU3hZdmZC?=
 =?utf-8?B?T2FFR2ZqVlNlRzd5U1k5TFpWTDh6V2lpaGN3SjZweGl2U09DMU9mMDd2V2dt?=
 =?utf-8?B?dG55a2FkNklsMUJoeDhobGN5NHR5Sit1VTlxRHg4Yi90alFZOTZRUENldm5M?=
 =?utf-8?B?d2pxTkJwL2lZNnRhK2phWndmSnROdTBtN04zaG9BUnRzSnRRUHNyamZSYmlD?=
 =?utf-8?B?aU1Pb24wSHgreHJMakhtMUduQ1IwWWtsTUhaYnRQSHNrSG1qZ3dQZkhkSlJh?=
 =?utf-8?B?ejMxU3h5NEdpZjJOTEErdzJZd0Z2aTFuc0tLeVJqeGdCY1oyRGxsa2pZajh5?=
 =?utf-8?B?M1cyZktkUjhvbWxOL0xsV0Z2eUU1ell6U0R5RVlGRmJjWTFyUTF1QTlKOVZJ?=
 =?utf-8?B?eFlIeWs0R3pUcG8yKzM0SzVhZTRzT1JuV2U4ZDY4UEFMbktGN0hSUWtwNGhJ?=
 =?utf-8?B?VHNtTWR2TkR3blV4WlJrdkhVdnppb3B1N2d2YXpBNFRkZFlYRTFzWExZZ2lM?=
 =?utf-8?B?OGpncHpKSmY3c09zRXZ3RVUwNVNoaVA4cU43S2VabTI0YmNYRXZFd1FNMnJt?=
 =?utf-8?B?VDAzY1VYZjNVRXNGQmZ1SGE0eHRDQWJhZFBKVnF5NHAveXFWNHBYcHNYSHdx?=
 =?utf-8?B?Sm9YM3AwdXhvSlRxVUpBek9oZDBNSVNKdE9hVDlJMnlad3pyYVRCNEZUWkpH?=
 =?utf-8?B?dEtZbkpCRkpQaGs1MkgvSi9neGlTWkI5YVFvbU5mSythZitOZnJSaE1lSE5J?=
 =?utf-8?B?VElTNWNxWWpQU2RET3I4NndpMzA1NFJKVjJtZWhSRjdKTUZoWmx0c0ZlNlBP?=
 =?utf-8?B?eDljUTlLbGs2Zjk0UmVudWExQnVWTWlvUEtzWEpqZ2k1NysxN3pyZkdiNG5O?=
 =?utf-8?B?ZTVqcEpYd29OVzhQK3dZK096QlVsMHc4WUtuN0lzc2NqOTk0WHF6L3FyQXVl?=
 =?utf-8?B?dTgvQTQ2QmhNRVFNQ2dRMWhQdncybTA4dXhKZ2pvN0xyb3gwSmJqV1d6ZDh6?=
 =?utf-8?B?bDdMdnR5NFdmSGg0RHFnaG9VcmFnbTY5WDVxN01XOStLdW9XWlF5MDNNTlNS?=
 =?utf-8?B?VW5Zb0l4RHZ3aDMybUVWNVl6SllMdUlvS0dWUUVHaEpiSjlzYlprNGQ3MFdI?=
 =?utf-8?B?SlJhNG9jeTZjbldmdlRKL1ZBclZyMTZuNW5LYXRGWGplVnZIZE1oWnRzc2Zq?=
 =?utf-8?B?eE1UM1RGRjRTOXptcWNIRXo5RXJFcVE2Q1JCVFl6eCs0OXFSOTFnckN2bVpH?=
 =?utf-8?B?aGpJODRFZnNBdTE1cnZqanhWTFZqenh1UzBxeS9WZEx0VGluRk5oWmhsUStX?=
 =?utf-8?B?QVY5Y2RVN1A3Z3lZbThpT0cveVhzK05PUTYrSWdQUzJ0U1JxL3BFWElxYVBl?=
 =?utf-8?B?K0ZCcTNVaGFiUGIvRHd0dk5iMFBaUUVoZXRaVTdIYklDbGMvZW5qdG9WelJm?=
 =?utf-8?B?ZXB3bVBBNmhqMnpqQjFIWHU5ZHp0aUxLVTBtRHdTSEZTZ0ZnTi91SFE0ZnlL?=
 =?utf-8?B?UVBzaXdTSDR4QVBpZWRXbXJNNzZrUHo4U05xck10cE1OVC9NbVJsekMrbGp5?=
 =?utf-8?B?QnVPcDg5WDhrSGc4Y1BDTkVvVW15WWpQZzN1djN3aU44WDMxajlYcEVJYXgv?=
 =?utf-8?B?SjdUdVBGVTBrOTFETkdEc3ZUR2RsRy9ySlUzRXF2NW9zdFU2T3hxNFlFdlVL?=
 =?utf-8?B?bXRaOGt2Q2hnUmtKMzdKS3ZBTUpsMk5lOFJoRDF0c2w4Yy8xRWhUUmU5Qk0w?=
 =?utf-8?B?cWhnUWdKRlFRMjA0TGpCT1hVVWpVdjUyZmt4US9aSDBzcERJY0dRNWxpVHpN?=
 =?utf-8?B?TUQwZnFITWdUSlBIM1ZLYlRUaU93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F3A27D62C8C6544B1D2C2359DD659E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vuQyE6fYcgKjLKERvUocEOuPLcyU0VoaVlGR//ugHUeMKPuq88xnOnKPqWPxP/fDzLSnQoy29gbLxG32Y0kTqSLx1PcEd7Tg25BRDKqPCnSLBnbvj0v+LCw6vcm1A2xSPQvKGqyd7zIsnsFGBIAxftBFkhIiPRHANtYM+/IfCOEsuyLtt7imkoqoYXSukUohNdqkBXffIZ6RHuNfiY8BUp7t6VpYAEP9DIdK29JwmlhvUEkFL+TcmmbBgI6mF8L/AT8sUpFeDTHacD5Q530r2A9xnP/wtQ2ZHi3Wer7pM0UckiXynhpozAcYtDkBM0+h+Kw4qQxEfwOCDPVvyUAVCPfXTKTkk+bkAuMJofQxCRaZBut7YlJCxfn6detjoXK1R7EATnXYWt4oQ8Ipvp3LXnboBFz0gpvdpihv3DkRFWJ8ryqqkJvN8xXXZu9fmEplWSQIz53yN7nOnv3JwrJH83zC+uznqmxCcQ6XzrEFx7EmcGH1V/JDKmByIoh5h0yFYCoSe1HIMzMzeALBBnLJcZUsC3uPpEjetJvjRwbXtF6SDzuLj63yHshvj2vBNhNJN+c5p5V1Y9fF08O8vzJzt4Zx9AuXO0ICb+lRK3gxyz1xDCyh8ewJ0doM8nJCD50W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9cfa4-ad78-4004-0411-08dc294e5b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:06:09.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mBYMBcYBwq0LncaJEQIkmTcxAVt5WI5FAkIj4v/I/hzwqEJdS5V1MLysSUwZKv+IOHYSUwbtpf8P4EmUGc6SgG6Zq5ZHMB7/dx1hSXR9Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7203

T24gMDkuMDIuMjQgMTA6MDEsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMDkuMDIu
MjQgMDk6MTcsIOmfqeS6juaDnyB3cm90ZToNCj4+DQo+PiDlnKggMjAyNC8yLzggMjA6NDIsIEpv
aGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+Pj4gT24gMDUuMDIuMjQgMDg6NTYsIFF1IFdlbnJ1
byB3cm90ZToNCj4+Pj4+ICDCoMKgID4gLi9udWxsYiBzZXR1cA0KPj4+Pj4gIMKgwqAgPiAuL251
bGxiIGNyZWF0ZSAtcyA0MDk2IC16IDI1Ng0KPj4+Pj4gIMKgwqAgPiAuL251bGxiIGNyZWF0ZSAt
cyA0MDk2IC16IDI1Ng0KPj4+Pj4gIMKgwqAgPiAuL251bGxiIGxzDQo+Pj4+PiAgwqDCoCA+IG1r
ZnMuYnRyZnMgLXMgMTZrIC9kZXYvbnVsbGIwDQo+Pj4+PiAgwqDCoCA+IG1vdW50IC9kZXYvbnVs
bGIwIC9tbnQvdG1wDQo+Pj4+PiAgwqDCoCA+IGJ0cmZzIGRldmljZSBhZGQgL2Rldi9udWxsYjEg
L21udC90bXANCj4+Pj4+ICDCoMKgID4gYnRyZnMgYmFsYW5jZSBzdGFydCAtZGNvbnZlcnQ9cmFp
ZDEgLW1jb252ZXJ0PXJhaWQxIC9tbnQvdG1wDQo+Pj4+IEp1c3Qgd2FudCB0byBiZSBzdXJlLCBm
b3IgeW91ciBjYXNlLCB5b3UncmUgZG9pbmcgdGhlIHNhbWUgbWtmcyAoNEsNCj4+Pj4gc2VjdG9y
c2l6ZSkgb24gdGhlIHBoeXNpY2FsIGRpc2ssIHRoZW4gYWRkIGEgbmV3IGRpc2ssIGFuZCBmaW5h
bGx5DQo+Pj4+IGJhbGFuY2VkIHRoZSBmcz8NCj4+Pj4NCj4+Pj4gSUlSQyB0aGUgYmFsYW5jZSBp
dHNlbGYgc2hvdWxkIG5vdCBzdWNjZWVkLCBubyBtYXR0ZXIgaWYgaXQncyBlbXVsYXRlZA0KPj4+
PiBvciByZWFsIGRpc2tzLCBhcyBkYXRhIFJBSUQxIHJlcXVpcmVzIHpvbmVkIFJTVCBzdXBwb3J0
Lg0KPj4+IEZvciBtZSwgYmFsYW5jZSBkb2Vzbid0IGFjY2VwdCBSQUlEIG9uIHpvbmVkIGRldmlj
ZXMsIGFzIGl0J3Mgc3VwcG9zZWQNCj4+PiB0byBkbzoNCj4+Pg0KPj4+IFvCoCAyMTIuNzIxODcy
XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jaw0K
Pj4+IGRldmljZSAvZGV2L252bWUybjEsIDE2MCB6b25lcyBvZiAxMzQyMTc3MjggYnl0ZXMNCj4+
PiBbwqAgMjEyLjcyNTY5NF0gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiBkaXNrIGFkZGVk
IC9kZXYvbnZtZTJuMQ0KPj4+IFvCoCAyMTIuNzQ0ODA3XSBCVFJGUyB3YXJuaW5nIChkZXZpY2Ug
bnZtZTFuMSk6IGJhbGFuY2U6IG1ldGFkYXRhIHByb2ZpbGUNCj4+PiBkdXAgaGFzIGxvd2VyIHJl
ZHVuZGFuY3kgdGhhbiBkYXRhIHByb2ZpbGUgcmFpZDENCj4+PiBbwqAgMjEyLjc0ODcwNl0gQlRS
RlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiBiYWxhbmNlOiBzdGFydA0KPj4+IC1kY29udmVydD1y
YWlkMQ0KPj4+IFvCoCAyMTIuNzUwMDA2XSBCVFJGUyBlcnJvciAoZGV2aWNlIG52bWUxbjEpOiB6
b25lZDogZGF0YSByYWlkMSBuZWVkcw0KPj4+IHJhaWQtc3RyaXBlLXRyZWUNCj4+PiBbwqAgMjEy
Ljc1MTI2N10gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiBiYWxhbmNlOiBlbmRlZCB3aXRo
DQo+Pj4gc3RhdHVzOiAtMjINCj4+IFRoaXMgaXMgdXNpbmcgbnZtZSBkcml2ZXIsIG1pbmUgaXMg
U0FUQS4gSXQgdGhpcyByZWxhdGVkPw0KPiANCj4gVGhlIG9ubHkgZGlmZmVyZW5jZSBoZXJlIChm
b3IgYnRyZnMpIGlzLCB0aGF0IGFuIFNNUiBIREQgY2FuIGhhdmUNCj4gY29udmVudGlvbmFsIHpv
bmVzLg0KPiANCj4gQnV0IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvKCkgZG9lcyBj
aGVjayBmb3IgdGhlIHByb2ZpbGUgaW4NCj4gYm90aCBjYXNlczoNCj4gDQo+IGJ0cmZzX2xvYWRf
YmxvY2tfZ3JvdXBfem9uZV9pbmZvKCkNCj4gYC0+IHN3aXRjaCAobWFwLT50eXBlICYgQlRSRlNf
QkxPQ0tfR1JPVVBfUFJPRklMRV9NQVNLKSB7DQo+ICAgICAgIGAtPiBjYXNlIEJUUkZTX0JMT0NL
X0dST1VQX1JBSUQxOg0KPiAgICAgICAgICAgYC0+IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFp
ZDEoKQ0KPiAgICAgICAgICAgICAgIGAtPiBpZiAoKG1hcC0+dHlwZSAmIEJUUkZTX0JMT0NLX0dS
T1VQX0RBVEEpICYmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIWZzX2luZm8tPnN0cmlwZV9y
b290KSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX2VyciguLi4pDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEkgZG9uJ3Qgc2VlIHRo
ZSBkaWZmZXJlbmNlIHlldC4gSSdsbCByZS1ydW4gYSB0ZXN0IG9uIGFuIFNNUiBkcml2ZSwganVz
dA0KPiB0byBiZSBzdXJlLg0KPiANCg0KDQpPaCBJIHRoaW5rIEkgc2VlIHRoZSBwcm9ibGVtIG5v
dywgY2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBwYXRjaDoNCmh0dHBzOi8vdGVybWJpbi5jb20v
ZnNzMA0K

