Return-Path: <linux-btrfs+bounces-22063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOsqIauJoWmVuAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22063-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:10:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F51B6F44
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790B330488CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC23DA7F6;
	Fri, 27 Feb 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N8xCP1Xs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VydzoAjY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B531279DC3
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194209; cv=fail; b=mqazXGFtUgURAI/l5y5OgLX/faIdCwYjGFSBq+Ug9DaQhRoq6Um6A5abdGWrau6MvKzDY4MYcSje8jpDFn7goH/gbhkYaIcuxPkGJ8M/WufQ+wp4uQKl7LAtrm/aFNLkOS2n33VEj5xjpTzr+sEogveLeE4qmo/mBhE17JMHQNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194209; c=relaxed/simple;
	bh=vi8r/oRauRGLcUTCd748jCROwP3edoVSeF0VPfnMTvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3gU4tLBtM6sYfobtXclEYGW3OBgIYwkwKfr00+Cltq73ZSmYukQMaTHwPH+2etN/s6n8XCNgntDKHRh6dem1YZOWgUaXVXGM7h8jGAoDxNp/djKcAF6ll6arqT4mTCRG5MijsHE3N4mI+Vr/vtQE/gAuCK0aiZir6vTAbT6MsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N8xCP1Xs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VydzoAjY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772194206; x=1803730206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vi8r/oRauRGLcUTCd748jCROwP3edoVSeF0VPfnMTvk=;
  b=N8xCP1XsCz6z1I8uDo8ODnlzeauq79WxFTycdPP2biHvbEhOmdxF/s35
   MQldEcTcHF9Z+m8ktBav7Bw6mxWKlMfKBuOZKjHNrOo+CPjkZfBom2FO/
   IC4pxSoR7VPkCWcJUkBbfh9gwtEyYMMqNcN35jNIM9O03rjg4f8m0PP46
   n4lYbOZ0Mg1v33hQalTnmELEiG0S+b52BQAXG+jQvyoZwKo3W/3Le4xfs
   6u3koiHrZjmoWdaEtelrWltyebxldzyD04Pwhic5LFBVZXvHmA7uzjE42
   AQngPF814Eiti3KW/oXQhkes8u8jn8w7kCpHKaRMBFTuZubamq3uai8dU
   A==;
X-CSE-ConnectionGUID: WOnKDveHTBqmLBsTe5lrjg==
X-CSE-MsgGUID: mnwFI1cQT36+zuW7hrZUow==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="142138519"
Received: from mail-westus3azon11010055.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.55])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 20:10:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEqFBzBthVU+WF47v0J+b5xoP1XlVDB9aXR33zd0CDOcwRW+TIphXTkgNzUWMrs+hXlVzHoHPT0/m77aIAOTZeRVQPAdOTikEFihCKPUZ+CDgc5MkApn093EiOysqw/dqrBvXE4S3jJ2k2joSVLF83IR3LxDaN3tFhHkYIEwZobWUkc7HzII1+K2ktUpWbDQIswBQqVoAXU2quOwfyL/ZLXk6y4XMWDO8/3D0wuYZSpSMfvQYWqT9uzz5NwWjQ9yvL4b3qYU4mnNTI9Ib6xIXtKcU3wY0fbvJBLfl/1eAVH9ExSVXBtrGJawtDCcMoe9LGYVAGQumlyZu/W1o9XygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi8r/oRauRGLcUTCd748jCROwP3edoVSeF0VPfnMTvk=;
 b=zHB8iw5gvAoFJ657Tp0EJ5WqYe2itcrP35PrqBUg3ZoXsqZMPDkIAEdqgIol47TcYHrOcid7vCGyfgMzPkH39+oTeGL/wGUJzxUajhqTUkUaRxQfZaqUNBbws0dNHdZdpN6gCCsv46OI292E057/Sc1g2TAUwgX9ZLz/zVXiNZhaBXk+jU2xojE3/wHJz5sv4uWdeXEWWGoTfl+QEKXCIcG8UsOCe/osyNzUQG3p0P9vhWPBMguv5zog/kTdtSIIlOuY90LrfIppco/A6Os9gfJkUQ1s9uFHphIizs4m9Ke8SuJyJBXnM6SR0bBM5IxOa9rw4anLdmTytGJ5DlwDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi8r/oRauRGLcUTCd748jCROwP3edoVSeF0VPfnMTvk=;
 b=VydzoAjYWZnT1hZKaSWN6e8hbJNB2kcJ3YYrF7EOhr3owFRmJo+goklPf0r6a8MFCA0Rq/eohfgjZnxwxa95PK79oYPvt2fgSydpBHRsI9CoxeY4oxzkbgPSG3oaGdI8kplOy7ySgNAtEP9TMDFv0vIW2l3iY/Lxqf43rJ+gRZs=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY5PR04MB6913.namprd04.prod.outlook.com (2603:10b6:a03:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:10:03 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 12:10:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: take rcu_read_lock before dereferencing
 device->name
Thread-Topic: [PATCH] btrfs: zoned: take rcu_read_lock before dereferencing
 device->name
Thread-Index: AQHcp99aqXeZ/BdD4k2cHnyIV5dvPbWWc6QAgAAAnQA=
Date: Fri, 27 Feb 2026 12:10:03 +0000
Message-ID: <40df9e2c-ebd6-417c-84aa-5588e43fe937@wdc.com>
References: <20260227115051.136255-1-johannes.thumshirn@wdc.com>
 <CAL3q7H4EC2EChn+JBc-CMOmfrVzqFMnwMSWV9AUO0iHb8zp--A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4EC2EChn+JBc-CMOmfrVzqFMnwMSWV9AUO0iHb8zp--A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY5PR04MB6913:EE_
x-ms-office365-filtering-correlation-id: a645efce-1b9d-4260-8f88-08de75f92340
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 NnLBuV89omWNzKhuY+QGKecGb3wJmvzpsjG1fz05Bmqm55Gsi/39Nz+xUWtzpsR2f8NApJMeGlR+utFZryfyP9383ELGOR1yhrLK7yC7yev7l1xFggfLBJxxH/sNq9yu5dI479tz+6wqdBasQryEF/zCwrKhnssquSmReUg67Er5OESbWmdYd0pwXFcYEUwoTfDd58zL6z4QmWCm8Oo3neOQ+DikIcEtKnyePVeh+YpbcEDc9S4Vm1sDXBDk4gSoYjFwQlF8UeqKj2Qu8cfqrZelz5c+jQLzQYJ0UML7NLkEhzvHnVPuqQmMKlXAJGizP5Y7vhXfWA+JkSfrpcrVi1wfVfP7yzOl34HruvgGWzzZd1kEdsoAdNvx3qsN17vfVidkM2C1ilo+XBSf7oJbwoFxC/+3pBj8nWWSYzEHypLCqkTkLoHAZkDvTYv31gv2Cs+CDsf79JwEIcp7u1tTSVQIaSZa4BtB8ky6dQ2RvAf+AxsQT/Ndpb43iMhRICRCjwiJ5JbzFqGf24ktbn3zCohfsTjCF8ndibVqP+PYWxoG8fe3MxC3MT3w8hOP73aYCfmezaXRjstCaIt6oGE0eIiRXX/jSEaofJ0VxehGsbbTrWX79EOaZCAxuxYWcduVT+xqxKXgCc7eMRy+QuGIPhH1NQiQAueb7UdIwszuPflIp/GDojezHVz3DH0m0ttMl4AR1CwMtoT1jmCJLNJNqCsvokDOsOpcDK+m0xWNdO8mmumchj5mfbuTDYhR8h28
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVczWG5qVDVYUHBJVzUxMkYxYkoweDFYSEs2ellKbzREeTduMUNDN0EvbTZW?=
 =?utf-8?B?UW5vVlJUdUoyMkQ1Qms3RDJjbFhnblEyc2ZVdm1seThrSnBUTE5ZN213cVhm?=
 =?utf-8?B?dmo2L256VVhFNVJOTm9lUVZqVHBiVDBia2c0bTZKcnlUZDlUajdvYjJxNGk5?=
 =?utf-8?B?MEROTFNMTXJJR211K2dmNHU2ZEErM1lqSmliR2ZoK2g3UTgyN2sraUVxbm52?=
 =?utf-8?B?bTdQQVpvd2xOU1RzZit3WUhuUFBSZm90NHNMTU1PWmJrOE0zZE01ZG01ZTRY?=
 =?utf-8?B?YkRzdWJFRFJWNGVDQStKUm00aHM5RitCVFFpdUlpWGY2ZjB2RWZvalhQdHdQ?=
 =?utf-8?B?Z3RmazBlR0gwM1ZyTVJ2NkZXTjhPbitDRGZHV0JLdDdQZ01XU3dxdWJKNTJi?=
 =?utf-8?B?SFBjY1RWY1JDdHgwMzIwR2pWSS9odmkrY1AyUFFKSTkyaUtycUY4VmdjWUIy?=
 =?utf-8?B?OWlBbFBta3EySTlkV2JmbVdBc00wR3J5bUtyWGxPSjNmclJJSUpHYVNwSUR5?=
 =?utf-8?B?bnhYVjM5Zk9qdUtsWWxpNmRiY3h2c2hsMGNzaCtLeWtSTGIrWlQySW5hcUdl?=
 =?utf-8?B?dzZrZHZ1R0lSR0xsci9NUHl4WlpTeEQ0aGtBMWY1VmJQak93aXFDanNyeEk5?=
 =?utf-8?B?aW5rMW15SEZ0Y0ZsQldTa2ZoZ1hJczZFZTFYcGQyM1ZqUFp2a3Z3TDY3a2I1?=
 =?utf-8?B?TnhSV3dUaXNURUFFWktQWWJVR3hJbThLV1FwZVFVMFh0R09NOTIrZ0tNYzU3?=
 =?utf-8?B?c0xOQTM0aDd3c0J3bmhBWU5NVXVNemRMQzNyNW1oRGxkbVB4VmlvUmFiZ3lP?=
 =?utf-8?B?TWFWYThJS3IvcTVoWnRPRWFYR3dqRDdDTFplcStDdnM2MDQwSllJU2szT3pi?=
 =?utf-8?B?aW5kMXhXdVR2Yzc2bmpVQTFTVHJmRXVEQ3hwNHlyWEFjTUxrVzJQSGo4eWU1?=
 =?utf-8?B?Y05xWlhIWU9EQjBJaVhPVmdGYVQvOTZOa3Z0aitPd3ByelFsTlpuQkZsRTJD?=
 =?utf-8?B?OXUycTFIbWU4WWpvNlNUN3VnS2tiOFNCSzR2ZFFQa2VqQ0Mrc1dZeCt6dXFP?=
 =?utf-8?B?eEJFRDlST3NhZ1NFbm90dVR6ZUVvOTQ2YUxBR00xc28vOEtWVi83STBIb3Rm?=
 =?utf-8?B?ZW0zTGs0RkxXOWhteDRqK29wUTg4ZlVtVzNEV21wMklaOFBDdUl2RDlZdlFW?=
 =?utf-8?B?RTRhUUpKZ1RyaW9VN0RDdlUrQjI4NkpFMHI3OG9maWJlbDM5bzlhcm42UmdO?=
 =?utf-8?B?cWxLK1cwc0hMWnVVWGdnSUxSMVMrZmN4cFIraFQzM3lZdzQrRXdGTW43MUpE?=
 =?utf-8?B?ME1HL3B0TWlGRkdWMDdrYXl5bXhkUXNucmt1WVdHcTEzMXdXM1JKczRtSk9t?=
 =?utf-8?B?bVB3RHJYNENBM2k4eDI5R2JpUkpicENwVkdLN3pjdFJZU3dtSmJzbEgycVpY?=
 =?utf-8?B?ZWs5TUZaVlJGY3dUZXNZNStvZmlFdmxUQ2kyTjZXNkdHK25Rb2tremdBeFg4?=
 =?utf-8?B?WTFRZ2tVblBrOWhuRzlKYzVURjZZdXRpcG9TY3pxeXZpMHExbWEzQitZdFd4?=
 =?utf-8?B?VFpFYUh0eVpPM2RRVVZmVFRGSVR4ZzV1VmJiYS9oNWFQTWdxYmpGcnJ2Skho?=
 =?utf-8?B?Y0RhOEM2eU1Rb0YwOXJhbDJ0OU5VZGtSL1F4b3lzTnBMTzlUeDZuY0NZZjhS?=
 =?utf-8?B?bFBweVdsSGZraUxESVAyUFJjT3JCT05TTUUrVkJySkdTb0E3dHU3Z3ZqTU52?=
 =?utf-8?B?RHFoSllza081OGgydldZbTFjQzVudTlYNHV3SW9nODdQREFUcVd1OFFUM2xs?=
 =?utf-8?B?cUg5a0NwYk1iY3Q5d3p2b0FCbEJTWDlSeUFFMnA0SW9yS2VPSzdoY3FwNWlT?=
 =?utf-8?B?a2dybkkyUytKM3NnK3ZaeGVWeVVBaDNOZEVWc2tYd1pmTkVxQ2J2Vm5iRkxI?=
 =?utf-8?B?c2JEczJWRCtKRXR4Mmw0Ky9TdDhRM0d1cG5XUUVZdkFXWHpBY001ditXdzRa?=
 =?utf-8?B?MXRPMGZFYk5UU0t3bHd0a1JBOHlycWJ1WFVzOHZYMFlaOHU4dURIOW1CYkJX?=
 =?utf-8?B?VERLMmdXZEtHd0hXUDJwWjdCYXh6UXErd21sRkNpazR0WnczbFNyQW9kR1Vv?=
 =?utf-8?B?QVFlYmNqVGpKd0t3eU16dHdOOVdhQ1Y0SHNkYUwvZ3lSRHhveSs5QWNPSFo3?=
 =?utf-8?B?bHU2c1FqNmNJNDArdWxyTkRlOEYyZklZYW1DK3o4VS9aNURXbWczQWRUUWdO?=
 =?utf-8?B?aEE1MG9VVkV3cW5YeHMyRDJIT2NCOUpwa09rdmNaa0VtNS9GTUc0cWp4bnJN?=
 =?utf-8?B?ZVJ2V1JNbHdneSt3dUsxZmNoa0JvM2JOVkpCQml2UnE5Z0xacG1rMmt4bjla?=
 =?utf-8?Q?/f3j8xFqMQ/hBUj8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1B4CD5C49D70D49B35CAC3A1FE1F973@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/NFTdS3GKyRcjkdONIpUzWUXY/h/MBTwekodAsOFnmhZVt3s2NwvT5bcy8HEblF/GqGQr1FF7PGuJyqOzCY+NCQjqfZBUSMEjvjxCVsuqNwPWEAgydJI+yoKlr+AKHX0wptEeqMjZOhk2nQ2z9aceqI9m0mvemEFbZrOT61ITo2d2JL0NUrjVARGP84ZZX66X1DMNbNp58KN3++GzPyruNyfRjuMdS+hKkPB9VUW3U5Sor1Ham8JNgR79jRwA2D4BNXxkJ39cmLeWGgp5+0NVplO46Ka3BCQWDuA2sKgiFXP965l9N2xxAt2Fu0WU0hZrJLIcTLSADbo1oH4vdgGy7NoOZyTbEJahtXJTcZhCCfJOt2WfVthpN1YIPsdivleGJptq/7VBKd1Z8WkBOUqhHXTH2Ol/hKrz9K9sCM49PoRT2idrHhGSApUnplhGgri5Hlll8f4OedXo/PT3WNRUCTwLI1gVDmngappF0cHDqVADasviuPapeOhd71RNOnuDH974RpzRdPBdA/xO+N3xWgahut0ma/gnjcPGcJViYjui7px92oTfJ//94x3Z73N2bvBkcRHIjI0snDMPhjlCpG2urLRWWwHFkwAJGTQeJQCH0MTS6lU3fVkHkYZxO6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a645efce-1b9d-4260-8f88-08de75f92340
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:10:03.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6AxCnfl73Nz8PxPLVkGmBb3Xwwb4AwRAqkOch9DQuDpdxBTDuv2XLRSnjunJyPqClJDn0XSA4V98HDTqDn5cSgRC2LNTsaRTS4PdFpDjTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22063-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim,wdc.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 2F7F51B6F44
X-Rspamd-Action: no action

T24gMi8yNy8yNiAxOjA4IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBGcmksIEZlYiAy
NywgMjAyNiBhdCAxMTo1MeKAr0FNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPj4gV2hlbiBtb3VudGluZyBhIHpvbmVkIGZpbGVzeXN0
ZW0gd2l0aCBsb2NrZGVwIGVuYWJsZWQsIHRoZSBmb2xsb3dpbmcgc3BsYXQNCj4+IGlzIGVtaXR0
ZWQ6DQo+Pg0KPj4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4gICBXQVJOSU5H
OiBzdXNwaWNpb3VzIFJDVSB1c2FnZQ0KPj4gICA3LjAuMC1yYzErICMzNTEgTm90IHRhaW50ZWQN
Cj4+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgZnMvYnRyZnMvem9uZWQu
Yzo1OTQgc3VzcGljaW91cyByY3VfZGVyZWZlcmVuY2VfY2hlY2soKSB1c2FnZSENCj4+DQo+PiAg
IG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6DQo+Pg0KPj4gICByY3Vf
c2NoZWR1bGVyX2FjdGl2ZSA9IDIsIGRlYnVnX2xvY2tzID0gMQ0KPj4gICAzIGxvY2tzIGhlbGQg
YnkgbW91bnQvNDU5Og0KPj4gICAgIzA6IGZmZmY4ODgxMDE0ZGVjNzggKCZmYy0+dWFwaV9tdXRl
eCl7Ky4rLn0tezQ6NH0sIGF0OiBfX2RvX3N5c19mc2NvbmZpZysweDJhZS8weDY4MA0KPj4gICAg
IzE6IGZmZmY4ODgxMDFkZGQwZTggKCZ0eXBlLT5zX3Vtb3VudF9rZXkjMzEvMSl7Ky4rLn0tezQ6
NH0sIGF0OiBhbGxvY19zdXBlcisweGMwLzB4M2UwDQo+PiAgICAjMjogZmZmZjg4ODEwMWUyOTRl
MCAoJmZzX2RldnMtPmRldmljZV9saXN0X211dGV4KXsrLisufS17NDo0fSwgYXQ6IGJ0cmZzX2dl
dF9kZXZfem9uZV9pbmZvX2FsbF9kZXZpY2VzKzB4NDUvMHg5MA0KPj4NCj4+ICAgc3RhY2sgYmFj
a3RyYWNlOg0KPj4gICBDUFU6IDIgVUlEOiAwIFBJRDogNDU5IENvbW06IG1vdW50IE5vdCB0YWlu
dGVkIDcuMC4wLXJjMSsgIzM1MSBQUkVFTVBUKGZ1bGwpDQo+PiAgIEhhcmR3YXJlIG5hbWU6IFFF
TVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTcuMC05LmZjNDMg
MDYvMTAvMjAyNQ0KPj4gICBDYWxsIFRyYWNlOg0KPj4gICAgPFRBU0s+DQo+PiAgICBkdW1wX3N0
YWNrX2x2bCsweDViLzB4ODANCj4+ICAgIGxvY2tkZXBfcmN1X3N1c3BpY2lvdXMuY29sZCsweDRl
LzB4YTMNCj4+ICAgIGJ0cmZzX2dldF9kZXZfem9uZV9pbmZvKzB4NDM0LzB4OWQwDQo+PiAgICBi
dHJmc19nZXRfZGV2X3pvbmVfaW5mb19hbGxfZGV2aWNlcysweDYyLzB4OTANCj4+ICAgIG9wZW5f
Y3RyZWUrMHhjZDIvMHgxNjc3DQo+PiAgICBidHJmc19nZXRfdHJlZS5jb2xkKzB4ZmMvMHgxZTMN
Cj4+ICAgID8gcmN1X2lzX3dhdGNoaW5nKzB4MTgvMHg1MA0KPj4gICAgdmZzX2dldF90cmVlKzB4
MjgvMHhiMA0KPj4gICAgX19kb19zeXNfZnNjb25maWcrMHgzMjQvMHg2ODANCj4+ICAgIGRvX3N5
c2NhbGxfNjQrMHg5Mi8weDRmMA0KPj4gICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NzYvMHg3ZQ0KPj4gICBSSVA6IDAwMzM6MHg3Zjg4ZDI5NGM0MGUNCj4+ICAgQ29kZTogNzMg
MDEgYzMgNDggOGIgMGQgZjIgMjkgMGYgMDAgZjcgZDggNjQgODkgMDEgNDggODMgYzggZmYgYzMg
MGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgZjMgMGYgMWUgZmEgNDkgODkgY2EgYjggYWYgMDEgMDAg
MDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCBjMiAyOSAwZiAw
MCBmNyBkOCA2NCA4OSAwMSA0OA0KPj4gICBSU1A6IDAwMmI6MDAwMDdmZmQ2NDJkMDVlOCBFRkxB
R1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMWFmDQo+PiAgIFJBWDogZmZmZmZm
ZmZmZmZmZmZkYSBSQlg6IDAwMDA1NWM4NjBkNDhiMTAgUkNYOiAwMDAwN2Y4OGQyOTRjNDBlDQo+
PiAgIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDYgUkRJOiAwMDAw
MDAwMDAwMDAwMDAzDQo+PiAgIFJCUDogMDAwMDdmZmQ2NDJkMDczMCBSMDg6IDAwMDAwMDAwMDAw
MDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+PiAgIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBS
MTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiAgIFIxMzogMDAw
MDU1Yzg2MGQ0OWM0MCBSMTQ6IDAwMDA3Zjg4ZDJhY2NhNjAgUjE1OiAwMDAwNTVjODYwZDQ5ZDA4
DQo+PiAgICA8L1RBU0s+DQo+PiAgIEJUUkZTIGluZm8gKGRldmljZSB2ZGEpOiBob3N0LW1hbmFn
ZWQgem9uZWQgYmxvY2sgZGV2aWNlIC9kZXYvdmRhLCA2NCB6b25lcyBvZiAyNjg0MzU0NTYgYnl0
ZXMNCj4+ICAgQlRSRlMgaW5mbyAoZGV2aWNlIHZkYSk6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRo
IHpvbmUgc2l6ZSAyNjg0MzU0NTYNCj4+ICAgQlRSRlMgaW5mbyAoZGV2aWNlIHZkYSk6IGNoZWNr
aW5nIFVVSUQgdHJlZQ0KPj4NCj4+IEZpeCBpdCBieSBob2xkaW5nIHRoZSByY19yZWFkX2xvY2sg
YmVmb3JlIGNhbGxpbmcgaW50byByY3VfZGVyZWZlcmVuY2UoKQ0KPj4gdG8gZGVyZWZlcmVuY2Ug
dGhlIHJjdSBwcm90ZWN0ZWQgZGV2aWNlLT5uYW1lIHBvaW50ZXIuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+
IC0tLQ0KPj4gICBmcy9idHJmcy96b25lZC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKystLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0K
Pj4gaW5kZXggYWIzMzBlYzk1N2JjLi5lNjlhMDVmNDkyYTYgMTAwNjQ0DQo+PiAtLS0gYS9mcy9i
dHJmcy96b25lZC5jDQo+PiArKysgYi9mcy9idHJmcy96b25lZC5jDQo+PiBAQCAtMSw1ICsxLDYg
QEANCj4+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+DQo+PiArI2lu
Y2x1ZGUgImxpbnV4L3JjdXBkYXRlLmgiDQo+PiAgICNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4N
Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2Jsa2Rl
di5oPg0KPj4gQEAgLTQwMSwxNyArNDAyLDIyIEBAIGludCBidHJmc19nZXRfZGV2X3pvbmVfaW5m
byhzdHJ1Y3QgYnRyZnNfZGV2aWNlICpkZXZpY2UsIGJvb2wgcG9wdWxhdGVfY2FjaGUpDQo+Pg0K
Pj4gICAgICAgICAgLyogV2UgcmVqZWN0IGRldmljZXMgd2l0aCBhIHpvbmUgc2l6ZSBsYXJnZXIg
dGhhbiA4R0IgKi8NCj4+ICAgICAgICAgIGlmICh6b25lX2luZm8tPnpvbmVfc2l6ZSA+IEJUUkZT
X01BWF9aT05FX1NJWkUpIHsNCj4+IC0gICAgICAgICAgICAgICBidHJmc19lcnIoZnNfaW5mbywN
Cj4+IC0gICAgICAgICAgICAgICAiem9uZWQ6ICVzOiB6b25lIHNpemUgJWxsdSBsYXJnZXIgdGhh
biBzdXBwb3J0ZWQgbWF4aW11bSAlbGx1IiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJjdV9kZXJlZmVyZW5jZShkZXZpY2UtPm5hbWUpLA0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgem9uZV9pbmZvLT56b25lX3NpemUsIEJUUkZTX01BWF9aT05FX1NJ
WkUpOw0KPj4gKyAgICAgICAgICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4+ICsgICAgICAgICAg
ICAgICBidHJmc19lcnIoDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBmc19pbmZvLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgInpvbmVkOiAlczogem9uZSBzaXplICVsbHUgbGFyZ2Vy
IHRoYW4gc3VwcG9ydGVkIG1heGltdW0gJWxsdSIsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICByY3VfZGVyZWZlcmVuY2UoZGV2aWNlLT5uYW1lKSwgem9uZV9pbmZvLT56b25lX3NpemUsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBCVFJGU19NQVhfWk9ORV9TSVpFKTsNCj4+ICsgICAg
ICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4gVGhpcyBzaG91bGRuJ3QgYmUgbmVlZGVk
Lg0KPg0KPiBUaGUgYnRyZnNfKiBwcmludCBoZWxwZXJzIGFyZSBkZWZpbmVkIGFzOg0KPg0KPiAj
ZGVmaW5lIGJ0cmZzX2Vycihmc19pbmZvLCBmbXQsIGFyZ3MuLi4pIFwNCj4gICAgICBidHJmc19w
cmludGtfaW5fcmN1KGZzX2luZm8sIExPR0xFVkVMX0VSUiwgZm10LCAjI2FyZ3MpDQo+DQo+ICNk
ZWZpbmUgYnRyZnNfcHJpbnRrX2luX3JjdShmc19pbmZvLCBsZXZlbCwgZm10LCBhcmdzLi4uKSBc
DQo+IGRvIHsgXA0KPiAgICAgcmN1X3JlYWRfbG9jaygpOyBcDQo+ICAgICBfYnRyZnNfcHJpbnRr
KGZzX2luZm8sIGxldmVsLCBmbXQsICMjYXJncyk7IFwNCj4gICAgIHJjdV9yZWFkX3VubG9jaygp
OyBcDQo+IH0gd2hpbGUgKDApDQo+DQo+IFNvIEkgdGhpbmsgeW91IHJhbiBpbnRvIHRoYXQgaW4g
YSBmb3ItbmV4dCBicmFuY2ggdGhhdCBoYWQgYSBwYXRjaA0KPiB0aGF0IHdhcyBkcm9wcGVkIHll
c3RlcmRheToNCj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvMjAyNjAy
MTMwOTUwLmRiMDU5YWM4LWxrcEBpbnRlbC5jb20vDQo+DQpBaCB0aGFua3MgSSdsbCByZWJhc2Ug
bXkgYnJhbmNoIHRoZW4uDQo=

