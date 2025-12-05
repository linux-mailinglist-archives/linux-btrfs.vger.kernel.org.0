Return-Path: <linux-btrfs+bounces-19542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51667CA71BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 11:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D33300EE79
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B8306B05;
	Fri,  5 Dec 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dAXPEFaV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bt9yr9J4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE16263F44
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929367; cv=fail; b=F3G0v+OJVdCZ85CoY4iwJjBjl+HF+pUM8XvUuYnp+3j5iiPoUp67WEjCAnZSyhuVcBr2pC8wNGbQcOL9r1O1UaUx+Rba0unKSDI1gOtnHhmxjny3tjWjgL9MUN/0wUcpxiUW1Oc5d8fALtRqpt4+z09uUMlGBFP3Nuvjovul1/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929367; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBJ+xq0qzKXDMiC2FP8zA/6IOtp4hnRHbCu3QkzFjqkgvdbpzejiI7Hx5lnF2btOwI+ioTe672knYJIVD3gaIzjrF/gJyqWzZd5VJNANe4r2aRqHeplUT2EQq5on+m7/aNT07fjtY4AvMcMvOML9smS5brUAHxqpQeIR5vHbYBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dAXPEFaV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bt9yr9J4; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764929361; x=1796465361;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=dAXPEFaVPecN8h/URNB5RcpwwodmW6+VaQ5c4E1Dy4UIewtEM9JlsY5i
   zCCA1Ekd2fbYXwM+TpCnPbESF4HYO3MmlqAPU2RWqRjQO67qLq7aGcBen
   RVltMBV+dDZifYbi2LutffxsTdZ6pkDRBLvqcLh62aqLvUadkV43QT14b
   P9fw6whSlGMSnmznQICKXNkGAqbQLXIBCs0Amolob8MkUun6JaialuADV
   Yys/QIh2li5pX7ysU+tGAmPiPt4AyPDC2Pe0OsrJ8GTd0qkXzzKNUrx80
   QV71D4LsD7b9DD0YgOnEht4pnsF4YRVMGp+PyL0cPEaoQPQt4SY3ss9hv
   A==;
X-CSE-ConnectionGUID: ox6tjmPZR6Swc/COeQkyCA==
X-CSE-MsgGUID: qKbBWXEpR+eatTe+40mD8Q==
X-IronPort-AV: E=Sophos;i="6.20,251,1758556800"; 
   d="scan'208";a="137327774"
Received: from mail-northcentralusazon11012003.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2025 18:09:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clhJCvBlP9c0nliyAvdKRwgsWW/Fh3qduX4/shJ00SHKMG38lQJE3aPeAs9y4BbCePIDM4OJhBKVtxxOFgzr2/7tFQeRorjoF1/pwIkz1tztBk8saHIz68ZTnQ3rNHNeo51SWbLx4OUfsHh15fff/KLFK/WwQRe0lC7dndG8+n9opbkcxxP1u3dlMEwkSTtXq2a/dQXVmUQGNonDLQV3xuSUM10Ei544wxzICU8VT0qOQK/+fwA8aeYRGIVxiTqOeHHv/dkd9zRUAfXVNyzEDolRBJ6WIs7bWqTKW4MlY8fhgg43HkTkeoVt7QaZfrTiqHEDalUq+MxC0C0he+DCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=q1ymtBYfIAdxhzNOy1pWqkg1PNGxTGFKGRa1mSQw5DuOXL0z4bltQBksbq5rPVL8ms7oEhgE7hlh/t9M/FDade3sTgY0JjqTOLmvXpGQ6/mQaeb6FnfQXBB1oMms3dBWPeDQ4h7wSCkLi8roq/0/+9+SiqEvxod/TMJMT84xIDY/JzI04D4HNDnHv9LkBetiu838NOAA4vi1NuDv/v650s+ey9qtrb9/EcInazYoRjmEEGpLCG/4G5RkuSHy8be21W4GIFWa5B8ZuI1i3Vf70W2QiLOJ9LqPy5uns+PcYDzmg6o3CnkEFoWh8fBqdyBnUjvDOd5TD7k7cgC8UgcjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Bt9yr9J4SDYmGg3OyANhbwLD04z79CaMUYlfDFy40E/1aTVGlvxjvS9oqIvDi305+hlFN4QtLzWCSZO7+NgHc3u2E348AXTn3rNRa5mwJ+YygtzdpP1O9r+i6MUQchYWyXTWwdL/oJnFLmJKqI4sXK3mFrBzxsA00YLDSpW9hLY=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM6PR04MB6313.namprd04.prod.outlook.com (2603:10b6:5:1e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 10:09:14 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 10:09:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
Thread-Topic: [PATCH] btrfs: shrink the size of btrfs_bio
Thread-Index: AQHcZcwsW5TMHybF0k6jS9Q+dM70SLUS0tCA
Date: Fri, 5 Dec 2025 10:09:13 +0000
Message-ID: <8367bc8b-533b-40b0-aaa6-1b8f0283f827@wdc.com>
References:
 <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
In-Reply-To:
 <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM6PR04MB6313:EE_
x-ms-office365-filtering-correlation-id: f2629fad-964c-4b17-821b-08de33e657ac
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?THREN3U5UHplK05xQ3F3cmhXcHA3V0RtRE5pclZZa1BmZ0dwM05CRlpEckNC?=
 =?utf-8?B?L2ZEc3J3emY5amZPVVpuN0ZrS1BXbVBWcThlQVlmbjdtL0V6K1RQNW5nOCta?=
 =?utf-8?B?VkRxcE9KYWtTRUJWb3R5eTE3TjVuR2lwZkZlTGtlanRyU2tVOWRYNVNLQ3A3?=
 =?utf-8?B?N1g1U3JQbG55alZaNFVNekVvT2JsdEh2bzN5QlM5RXBUQ1B5YzVTcDRHaFRz?=
 =?utf-8?B?ajRnZ20vbHZGN1ZIbmFoZVE0enBRbDdsOFozK2VpZ1ljR3Z6RkVOM2RZMmVE?=
 =?utf-8?B?MG1lcFJMYXZYc2J2bk9KcWhhSkwyTllvcm9OREV2VmFXZm5uY1paNFMxZnNZ?=
 =?utf-8?B?Z1ptek1wQUVnbEZGM0UxemdYWVdjTXZVK24vd3pZTS8xL0plUm9WZWhLL1cy?=
 =?utf-8?B?WHZrRWIyNmpxdHRTdFdzVXl4RURUN09LVFdwRW5uRklZYkNrUUErcHlBclpW?=
 =?utf-8?B?TjIxcm9aZE42T1hoeGFXS2FiejlqQlBqTXFZTnIrcjZUNnpud2FMUFJpYXQy?=
 =?utf-8?B?ZTEvd2ljVVZVSFg4Q0JuM0ovZDJTdHJMT3Ezci9OQ3N6bnUwU05DSnlHVjZM?=
 =?utf-8?B?YzFJUEF5cWtEVlJvZnZDazJxdm5VMEJlUVZ4cnNpNkUvSnptQnU1V0JLd1d3?=
 =?utf-8?B?MDdMc29POGREQ0taMTdlYU5hQ0NoMGNZTGFxd3lsaXNnRGswWlBqeGZvb09n?=
 =?utf-8?B?QzZzR3BVd3d5eS9aL2FFUHhITGZ4QmQ4R0daQjVvU3VlMzBCYUhsTmNDNllF?=
 =?utf-8?B?YUtOQ1BOVkZsb21ZUURnN3E1d3hQK2E4WDhVcEZRbnlDbSt5VmhqbXNpVG5l?=
 =?utf-8?B?VTRiWWI4ZlFydWh4WHJQeTVHR0h6d3BneU9aV29tbWdxazV6WExGSHZIV3JE?=
 =?utf-8?B?cVIxU1Zha25nQTA4QlRrbFVxMTJwNkE5ekJOcVp2aXozQ2Q0b2xmM3BRaEFq?=
 =?utf-8?B?UTgvNm03V0RlcGNEdENVSUd1UXAwUllueXhneHpjQ0g5WlZ1bHlYcjN2ZHdk?=
 =?utf-8?B?eW55RDEycDVmKzFhV00wN3RrR1g4bTN4MFFtS3Q1Z2d2SmkrN2JKNVBCcWJZ?=
 =?utf-8?B?MmV0SUxPK29Wa1ZHK1ZzekV6SlRBSWRZdjMwakxOd1pqWHFuWkJXcXpXdTNJ?=
 =?utf-8?B?QXpIY0swMnQ1d0tmeWR6cTRlRkFmdUpQV0RaREdZaEk3Nng2ckxZZGtwaEsw?=
 =?utf-8?B?UkNBZExyZHNIaDlWaDVxMmZOdlROVGEwNmRydDZFYmNpd215Sno5VTJWQTBK?=
 =?utf-8?B?ZHpnaS94NEI2QUtXZCsyVjJWRnNxZG1oUmV4QUlFR1ZUd29lc1o1TGFXYlly?=
 =?utf-8?B?ZytzVkk1a0FhTXo4aDhaNlR1ZHNRQnBQV3EvM2E4dGVRWVZlTTdzQ1FYdXpP?=
 =?utf-8?B?ZWUrTXFZcGwwZGdJeHhOU3JvVStBMFRHakJLaXlqZHFJdmUwbjlBYk9mL1RC?=
 =?utf-8?B?ZkdIYVBNTlRDekttM3VMajdnTlJST2Q5M3Via05nNCtHMHYzZGRYQ2sxVEsx?=
 =?utf-8?B?ZHo5bjF5amdQTXpnZzlvTmxiTm04ME9sdk8wQkxpempCNkNvaW1uOEFNZEVR?=
 =?utf-8?B?T2ZwV0c3dkpldCttWE5lWHF0alE0RjBSeUZGSkRhWHZhQTJqZi9DOXVVU0I4?=
 =?utf-8?B?SFo4TGgwNHh3NU9aM2Z5SjNZV3ZydUNYZ2NkL0hWYlZIemY4VDQybzU2a05p?=
 =?utf-8?B?eTUxUzVFdnh1RFI0MzllWmdreGJQNjNVWmU5TFhtTy9Kc1pTNGpjV1hZL014?=
 =?utf-8?B?eXFJaTQ1aXhJSTJwbXI3UDBRcGRuTVp1UURBRHM0MTZJOUorQjFDdk1MQ3pC?=
 =?utf-8?B?R0hJendCWXlkeFRIdmhrcTdYVkpud1BGRllDLzdjMlMyUTRQNWswL25PNVVa?=
 =?utf-8?B?RXhzVkszU1Jvd1JqODlBYmROWnQrd3hzNDl6d1Q2eE9Gd0FGdThUS1k3WUsv?=
 =?utf-8?B?NjVpQUo1bDhnb20zemZ0NzlCdWplNENNL3YzdzFWOEpERHpKb2wrTHgzbjZR?=
 =?utf-8?B?VkQwc2svRlU4cXpNUjNSTmx6RmpnbFBpanRyN05NOHp5bnVmVVJHUnRJN3lZ?=
 =?utf-8?Q?0RQqVY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTZNSXMxRTN6L3hiYXFXMFFaSmptLzFpcHVPYXNTNjhHeEtGNjhZU3BoQzlI?=
 =?utf-8?B?RG82b01MWTdoMzNpUU9tNE5BRzdKcEkvajk5Y1RUMzJFSVNTMUZ4N043YWJh?=
 =?utf-8?B?eGU4Kzc5MUNvUk9tNlVWR25iRzQ3WCt5dnhhK2lDVlFreWZvV25ydVNSOUMz?=
 =?utf-8?B?bjMrUnppSHRha0dDR2NZdW5iQlpiRG9ZNVlkbTVmNnJ3NWlUUlBpOGdNTnhJ?=
 =?utf-8?B?ZzlKWEpQc2RYY0tOMjY1OVFGdmJkYnhnTnZOR1VRa1dwTXFXZExnNFh5amRK?=
 =?utf-8?B?ZlgyMEE2ZnRPcldTYjNGSk4zeGFpbi9IMnZ1dnY5S2k5NU5naldpNy8xQWYv?=
 =?utf-8?B?ZUNKay9aOG5vd0JjTVRDVS9VZGQ4Z3hlY0dDL0JZajRXRXJBY0xxVk5TZDdZ?=
 =?utf-8?B?YUhENVJGREFwM0pxNDF0T2dFN2R1T1NxcHZTdWgvNTFzVXUveXRZa2xyN0Fs?=
 =?utf-8?B?RDhNR01nNzJxZmpzVzZ1RllxbTVvU2ZlUWxZdTVrbURDTHhzZTNoR0ZmblJJ?=
 =?utf-8?B?bndIU1hoQnlkcWVwOVN2ZlBGZWZXNW9sdHp6YWJuRVdJMmlGenlvbHhLSVdC?=
 =?utf-8?B?QVpMZG9kN3JnNUg4dUFDdXZRQ1dDUTZGWDExR1ZxVVBGQjlYWFJQQmZpWnFW?=
 =?utf-8?B?SE94WHlUMUJ0dFdjbHUrTDFFRzU4NWFTRXA0SkJyejU3MFNycFVVbG1kVUFP?=
 =?utf-8?B?ZHdoM2Z1bUhEQ1NoQjA3dkFhdnJkZ0c0bDlGY3ZWeFUyZ0xnZmRlWTM0NElN?=
 =?utf-8?B?VUpZUjUwb0ZyNjZIaGVkdWpRM2Y3enpXNXpqVll1c2RLSlhwS2Z2c2tYTTVr?=
 =?utf-8?B?VTFiWDdqUGFrZlpoK3VSaGRseGx1NDVDTzFTNTZDdEN5dzhlQW95bGQ2NXM3?=
 =?utf-8?B?Y1ViWnFaZlBlWG1MeER0NGwvcDR2aG5GTmdaRWRQZFdiTEQzWDdTbU5lck9n?=
 =?utf-8?B?K2Z0WGxuMzQvLzVXV0hnN3BkYkp2YXY5bmJCUUdDL1VPK3V3VGpyYlQyWlo2?=
 =?utf-8?B?Yk4yYlpxZkY4Y1ZmRDArVytNQXhGazE5eStydDlzSHRQRXJaSHg2SkFpWlda?=
 =?utf-8?B?OUpVNEZLbDF2aXkyZ3dWZjdmb0hzb0dMUG9tbkR3ZUNhTGd0V3oySXRsQ3JC?=
 =?utf-8?B?eDdKcU41TXNGdjFKdENFQjBCd1dNK1U4UzBHaFBGMHd2SEFrT0pQU1Q3bkkz?=
 =?utf-8?B?aGxBbnRjNDVvdm5hUm1jRHBoWHM5SzBiSkJ6bEQ1T1lnUXlDNHVzdjlVZVR0?=
 =?utf-8?B?dHB3N0ZtVTFTbEpJQWFVT0I2bkVIeDBWY1lweDFhai82RHVQbW1MU3BDdVVp?=
 =?utf-8?B?dmRHZEhuM2VQSHV5NXZVQ0FCZkZHakpEalJqYU5KSitPb2FiRzAxWWpFakwv?=
 =?utf-8?B?TUtSakUwQ3Z6VzhESjFNRG85K21QdTk2S25hOTZqNEM4WXpaZFF5eWR2ZjhC?=
 =?utf-8?B?WjhDRmJsbEJTbEExeEw4RUNEM1B4eFV5VlFqaGdBSWpGR2lwdmpOYjBOWUJl?=
 =?utf-8?B?L3pSWWsxWlRwT2VZWlFGUUpDNE1CaDdxYzZZOW9DVFNWaWNiMGRINE1ub2l3?=
 =?utf-8?B?UjhzcEQ2Y29aWW4xUjBvdGVOUkh4THRFaW9wcHhBZnh2Z2l5ck4zcFNDblpJ?=
 =?utf-8?B?T1dYd1BSaUZCLzh4Y29PNElFUGcycWlIS3lEMlNvNGxXeW8rMmVTeTJaY2hs?=
 =?utf-8?B?M2IwamU5LzZzYnVHQnFidGl5WXdoOVRZeGpoSFpIRDljTFQ4RzROWjlkQXVM?=
 =?utf-8?B?eTVhRjhPWDhjaFZUVC9FNTNoRTBRRUxJczk5TmRHcG5uOEVaQXBjUjJhNS9Y?=
 =?utf-8?B?dnU0OTVLWjFYNXFXaW9XZUxWVGZiYzZjSThkcHdQRjB4bjBWU3VSOFkwSmRO?=
 =?utf-8?B?U2xxcWFQZzlOTmwyV2VnQ0J2Qll3M3VVSUZWc1R4eWxjWmZLOE5ybTZ5VlZD?=
 =?utf-8?B?UFk3SGZ2Nzd1N2dFbWtmTWNZRnF4aXVXcXZNazJwdXgxMmZYbTc2ZytxMlpN?=
 =?utf-8?B?OFo3cVRUdDJMbHk5c1VFZFY0bzY4QjM2LzVSMWVRcEtuRDVvc1JXSDJCOS84?=
 =?utf-8?B?MUkyYzVwQzJQUG5WWWYvRWFpdkZjT1VnZGxoYzhuUHo2aS9SOXhPVlpHRUF0?=
 =?utf-8?B?ZHhqbHl4WGhQNlBndGJ1bUxSbnVDbEN3UW1Jc2RBbnVtd2h4QWFRVzJybXlv?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23594B2ACE90C24B969B0BF70EEF521D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vjS75A9T5IHidQTyKtaXs8CSv6hmKW45MmDjlYR8rU2K82YVtwiu/v6z8kwOHxEw8mBU8a5lzDaWE0oh4tzMejKmkVX5nr/HowK02pG6YAiejNImkbVELzMvKkQpfPE5k74jSH5dhTQLIavgFnTzjdX6c3rbp1k3kg5EXg9fD3y+mnip/FI28kmoSPOwDcNWEvqv/DILuNeoW6zkDoTXKpkrvt5sqR+EqeC5CQleMlyGNfQ56qB7DVVRGtKMyGi6060KTl/oIQJvEXqssnqA093spLnVENHYF3LPCpqkTeNUXYQ9SEWGq0qszj3wqsD0BTmBcHb2Sc/xkIxLd8eP8UA4m7P5sMYE0YhLIggVgHC/8OxKOOFwHdjCoa38Fo/c7wXpNFQgtOatp02i+S91C2pZaOfpAzPsin3zNuYV3HRW5yrgFZrOMQlGPPK4Jv1Re4yDi4ZOpRuKd0s+hat0O/kjzrwghhWTZLbrv2mK9osVcrKjlmh7dtjFAKar+lX7w2QZ0vjZAVRjoL5awaZXiXHImAClrT4OzqWotHLlBqBMqpwFZ4Cn98eONjm/4Y3VCAQoiW8GeyDJByyk+7ctI/MQwc4bkMzbLvrel4iWYQRFO+bf+aVdogbWhsflBIPc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2629fad-964c-4b17-821b-08de33e657ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 10:09:13.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIMy+i0YkTvDxARgTah9RFPJu7Hxy+GKRGi2A0CsxMhkEvCuYVOTrmy3Wkn8qeLd61+/JbjbbY10h2QjKyFkJP20lmDMLbHwZwJW5gSTYoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6313

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

