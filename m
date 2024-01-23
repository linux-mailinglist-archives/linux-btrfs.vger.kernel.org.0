Return-Path: <linux-btrfs+bounces-1639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DEA83883E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 08:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3842F1C23D5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3D5473D;
	Tue, 23 Jan 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jV7Cb110";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PdqE/Iak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0D52F77;
	Tue, 23 Jan 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996168; cv=fail; b=Y/x1L37+pHMm1eP7pQyC+1PWn2LRZCTwP9IAjSqsFu/qh8sDgRMmBnWPgV7Set2OkstpSQsCE28y1K67KiAoBgJobxd1pYUzTFepFYs5oAiq7g2Rar66yCYgwbtx/6swCz7q095u8j6y9+6UN36nTd/0ShnWX4JTLSdcmj7Uovk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996168; c=relaxed/simple;
	bh=HUNXDTjzHJT4CGcnxz76bcmZ3k5AsMpAYLVRFyWr6lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euEQ2h9uQqpSX449hl1k2Cv7Flm2Ld+xkkUoeZcn2TGXnDNLvswS2CBDeszwFSawHoNsahfrlVGaCqK1OKgkWnQfjFrTKOEOdKPlWAqnVYFkwR7NW6PkMio7qVIZwdBzoMVQ6Z9u2cU0q+0gUPgl+fJEdb0e7uCytQidaQ0xnJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jV7Cb110; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PdqE/Iak; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705996167; x=1737532167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HUNXDTjzHJT4CGcnxz76bcmZ3k5AsMpAYLVRFyWr6lc=;
  b=jV7Cb110Okwpw6QPIhPo1Al52ul1D8TJkcySH9dCcpbpd6ng461Sjt+B
   utUXHRsb/SBF0PMofc8mnhKUWmTlEROzagFx8Xsc1LXRTb/14+GVHCbB/
   RmbPy52481OOTLsv5PgRMhc/c2THZpjekN1G2eoqZ1S1rmgBSC/oBlbbv
   KXSk3n4j5MTYswFUfppj2EtUTKRMh51G1eR3BsmjwVXRSQtrEZJZf7mrK
   AhcDGgotQWIJ4RtaEwSZrUGtRVCwOiueHqN9zKhKMa3Le5MPUV/CSn86Z
   SxWC6X/BJkTd5W2mq9IBiB0vVzR/BzaGQwsabGDPsrpMKB/u/2NFPkgkV
   Q==;
X-CSE-ConnectionGUID: 9gFYPz4LRQKKw5mIlzJ95A==
X-CSE-MsgGUID: 7GzoLJTVTEmAFTMuQzaQ7g==
X-IronPort-AV: E=Sophos;i="6.05,213,1701100800"; 
   d="scan'208";a="7232769"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 15:49:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZGpv/QzJ6cbdWdTvK7OH1PyRBzZEHG7IB7WEwLRsn1Yx6VQl/EYXZnTBbkSEYBqpEVtdCdMV2jk07sWX8g2pY4+RsZzn0XvTVtxqtEuznECblhWXnBnf57J11ndFmfBv1FcF1qgtdX5xffvJr9Ycj9fDkv0I1w4eXABMN51rwgmDiMp3H4ZrueXw+Fz6w7K1G+65yC1eRHnL9cGp0WNY4VnYT5bIWTycuqCG2Ra+Kla0Pr221W9BAXfqqS4u/qPnYbCUWXzkJv6NxHzNdJJszpOybqbbFTH4O+IJbtI0K7owJm9yOrzwBwGR07Rnu2X6xxdOmv78cdeq4HLP6tLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUNXDTjzHJT4CGcnxz76bcmZ3k5AsMpAYLVRFyWr6lc=;
 b=n/49j8+KADhO7uXr0WcBoQUNQ+jFCxcDKlnYElf/bdvqLfUs8xRTqq9DmsUjuyW4QXsE9ckx1OwhbvZnmnKMC6rir8MzoJSpKZNMuaWz24V7H+K20amUkA7Nnt4ZQtBS9RHzUlKmkyohDKdWz5ElL/NvN3hNUUv3nqyoVspshmmlKCKo2oNjF6JF/SWBncM1UPm1inlD1BtXMCMYLpIeuVzoiNkbJ7QCTVuJJoGhssj18o2ODn9CCX51rxtTcXmiCISg+XTeOGg8LM6r3dKU3qy9JCm5SGgNxN9Za5LuhH88MWnsfVVIROLEYu0+LfgXvJk8ELYJ6O8fH+lKLeb/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUNXDTjzHJT4CGcnxz76bcmZ3k5AsMpAYLVRFyWr6lc=;
 b=PdqE/IakVZGRcLz29h+W1MzTcorLJafdLbGSfhqt/ELGhYBx0n88EBjpGsUtF/l7wUyudM/bGWzPeunBb+iJUcnYlWF4VNVsX8gx4v0ur/SXsFLMP3KJX0OAOwk0N9qrZtYUs+v1Yuhi+Vj7PX5JDbg3snblLkRy3UY9bxBOQnQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6460.namprd04.prod.outlook.com (2603:10b6:5:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 07:49:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 07:49:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Thread-Topic: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Thread-Index: AQHaTSDuFsakiAA56k+92pQQo+2DS7DmW0wAgACrzQA=
Date: Tue, 23 Jan 2024 07:49:22 +0000
Message-ID: <9ab48353-2033-4ab6-8334-28859d5e9e0f@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
 <20240122213428.GE31555@twin.jikos.cz>
In-Reply-To: <20240122213428.GE31555@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6460:EE_
x-ms-office365-filtering-correlation-id: 326749d1-7b33-4768-6377-08dc1be7d070
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 56fLNLA5fUC9bvO91guXgGetUifjoVqJIT8r5M0oK9hUZEKnoMoolLsXrmLYK6oc87I7KBZzp7GPdSHrkMVGkSiO3mgAeCJUvGt7PER0cKFY7si7dZdSAGI/k7H4NOJCZNEk7tRL8C4HzTU8BNNG4q1r88A84L0wxyVMAjs+LYi07sVlDoACKQ8ZYdbCPkyXEyl2wRrv9tVQRXGZeS/9nxGnRGSx1AQKCU8aJ2cYdVV8Hdb4Yh4FEKqXVG117Lz/vpqNr3PgKqbxQ/9yhYTNy7A2/C/xgbsIw6n82fHDQFGhADz6+vMUnUV7xWEt4BOXO+blCBDhAI9LA0zhaFLoSAngJImLPHdgkeOoISpTDkymmPkD0ijs+Tqto52kw0jdk+rSmuYJDY7fllalxVBYSZOQIz2e6sGbB49ph4/Frrotg9iGzEOh7HE8F/Iyz4zoNTAraJ177ToYiyR9+vmSoo8CYWilQ443KJk5ZF7Ehp07XDyTMAWSWn2l7X45iwV7GWaEiuWg7ehtLzXUwnfSi14vjEnrT+E+tCsqNcGLJ8gJQ+Uyl5eQgBdnCC2CFQueVLKe+FZ7fcu7ESNDJBeseHy+WRzn7pRuDZFLEiNgP8bEMIKwTstTtH+TMDoH41ZiNEaZv7LuAiQWpNyh9ytfdFyQC/EMXy2bKqfXxEHrOuDTDDW1ZJUNnOuRsuPPTT5j
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(36756003)(38070700009)(316002)(54906003)(64756008)(66446008)(91956017)(6916009)(76116006)(66946007)(66556008)(66476007)(38100700002)(122000001)(31686004)(82960400001)(53546011)(83380400001)(2616005)(71200400001)(6512007)(6506007)(41300700001)(478600001)(6486002)(5660300002)(4326008)(2906002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0p3QlQzNUVkM2o4LzNCbDdlb2hxY0N2cXU0SmQ5WCtnU0FzQTh0VlVyNjkw?=
 =?utf-8?B?QXRlTXBDd3JodmtPeWFSTm1kaEZQdVozazZMT3BXR05FZUJjWGQva2hJVFMv?=
 =?utf-8?B?U0VYMHZ4SldLRm81WStBMFQzOVZsNm52U05iR3NpV3dHUEdhVG9OUDlvYnVs?=
 =?utf-8?B?cTIyRzVaVzAyOHpmSTZmdS9VOTdNRTdBbUJUSUpFVTRZb3dVaWt1NDhEREhU?=
 =?utf-8?B?NkpqY1Q1U2lRZURjYXdweGZuSkczZi9yWk5CV1J5WTV5NjNOY2ZJdmhLTHFt?=
 =?utf-8?B?aVNUU2t4bWhLNzd5ZUxpNVZ0TVM1bTVaSFZ4dE1WK3dXQXlkeStnVlYyUlB6?=
 =?utf-8?B?Y2RrRUs3cTlVczBTdlhzL1haYWJHQi96ZlUwZk1RNzR5UnZLNXpneFNrU3Z5?=
 =?utf-8?B?TzFuK1pEZEE5REtqWFpZQWtrL0NldEVDaFNOUFh6M1FabnVqVldGQ1lHTDRn?=
 =?utf-8?B?VVlDeEVEc3lqUC9mYTFRdHJMUzJaWlpFMC9xTGdQYXJDUDNoSEt5ZjRPVW1N?=
 =?utf-8?B?S3ZkSGJ0VVptYmhOR3pZMXREblFFa0xnWU1YZXdtQmhmR2ovSE1RYjJtWDB6?=
 =?utf-8?B?OW1WcGV0NVFYY01sYXhUcVkwNWJ6WVlscWxCR0xRUjM2SWhldUpmZ0ZxOUZ4?=
 =?utf-8?B?aUtqcjlDZEdEbHFmQW8rMksySXJkdEVraldFZm0xc3FxeXQrNWk3cXBWSG9H?=
 =?utf-8?B?NGJYQjdqTEhhVXVZNHFKY0h5OThHaEdxYjZwVlJ6eTFJc1pzQXUydkZmSU52?=
 =?utf-8?B?SXZtK2pLckVta3JtUW11SStEOVhMRlpTczNrRnNac2JjZFphYkdlS29OZ2pU?=
 =?utf-8?B?cjlQMlA3V3lrRHYwc21FRy9pZ1NEZmNicUpqTzZ4OVh3VHVLRWpVczd1aExz?=
 =?utf-8?B?cndGbGFuRGJhaWFhZ25adE00ZTFZTXlWbEtRU2ZlZ0lyVStpSHh4UjUwb214?=
 =?utf-8?B?aXVSNldqeDFURjNXTmJxV3FLODN4VUxpK2gycDlvMzlvSWFxbHJpNnY5NER1?=
 =?utf-8?B?bDk1c080aXRramxvUVpkWS93VVkwUTNMek9hNGozUW1aaThuN0gvWG9PTmhL?=
 =?utf-8?B?V3BQeU1iRWlYM1pEclZVNjljUnl5WHBhbmxFN0N2MjRyZTdnUTRRbmVEaHYy?=
 =?utf-8?B?VUdETzYzT0VpYStrSHphRmJvQUc0Rzk5cTVFK3NVQkp3VklSOHZCQ2U0bGJ6?=
 =?utf-8?B?RktaT2puV3pWRmJ2a2F2aEF6RUM5aS9xS1JEREVJOXJkWDBNcXJCbnJmM3hl?=
 =?utf-8?B?NC83NytCeTBDZ3EwQm54VjJWQXpkMEU2S3RzcmVuYjBoNmpHVHVyWmF5ZDNX?=
 =?utf-8?B?eFo3WnFUdDBOZCs5Y3RSNmdUNC92Z3A2cWRoTGRzb0tYSlI1ekN3U2VsZ2RN?=
 =?utf-8?B?M01EQlhKcVhJU0FxdDBDaUI4d1ZjMFBoOWlTZ1B3VEVOY0oyakkzNzBFVWx5?=
 =?utf-8?B?dWdBNGxQZnJhS2hwb1d1ZWN6OUVKUUFNVDcxWTZ0c3ZGK0huUklBQUU1dktS?=
 =?utf-8?B?OXBRTWdCcXEzSkpHN3IxTkZFdmtza1hFNk1vaGZ3czlmZU9QQU0xcGRPbDVS?=
 =?utf-8?B?akdnajhvMkNFaUJmUEoxemg4ZXlCWUlOa0ovUjZXaUowSEtrSHlzbmw3cFp0?=
 =?utf-8?B?cTROUEFLU1h1UVMrUjVhNkVoSjh0TTd4RkFJQ1NzWmVpcFlvTHF3ZTBmellD?=
 =?utf-8?B?K2hFeTlyeGRuR3hzbGRMNFljQzF1Z1ZQbE96MnROcy9SZTFPSFkya1VRRlh6?=
 =?utf-8?B?cGpPMGlCSGwvMm95TXhlckdRakltWEUxTVlCY3V5RFQ5WDdUMk1Wa3N5NEhJ?=
 =?utf-8?B?dThvNHFQbUIxVFJLRHJKSmZiYkJ1S3ZBOGZIa1cwTCtvMFNkVytIWUllejR0?=
 =?utf-8?B?SGJSdGZ0QStiT3BqZjNpNnBSTjgwZXdtcWlYcjBuRFNnZTh4ZjRRbWtSdFlp?=
 =?utf-8?B?K0t3akxqYXU3R0R2OWFkN1d0WEJVSEZWSlZsYTJVdTJtZG5aY1lVcFRaUXdK?=
 =?utf-8?B?S0JrZEU0NWZlUjAzZGV0eFZVeTkvOEdhYkY3MFRZQUlVb24xbk5mMFFvVE5h?=
 =?utf-8?B?SUtsSFlUeE1YSmtoU2dGMGFGRTE1d1U3b3AraXJ0ZU9QRlBkSW01bm5PZGVR?=
 =?utf-8?B?TWNlajl5aGpUTk51WFZjTkdIWWtXbzNxazYzVmJxMVNWdDA2akUybEtwYU0r?=
 =?utf-8?B?a2ZKNFFpOXNmZG03c3V2V21sZFJHN2w1K2J3NkdBaHhpSU5hQnBYZGNraEti?=
 =?utf-8?B?WWhhdUYwOU5MdGFacThqSmphLzZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D694F374174C94DA679BCE1E037B8E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AKjLSaRJ7ZdEqL7OqBfK1StRAaRXb+o8tVlFBxZul4A7jMYznpIe2ZeVyZy1FXKvcMIo+H4Zmw3KuqfgFdcSdX82LmGyezuSDOfJBEHRI9j9iMLJjy0kNQyXXpCH2s6Y6PB5vyLR56vxv/el13HovyvQUQkKhkTWjFDjd1rUsH62WLQQwq6y3REHVfuwrhxeoKNJQeUKfMC898lQDjV9BWId+AD+U9bNo47LrD2A5rqJz2oJ3PDuB5wAU6DlprJNZXQ+TDt4PLGEiiBiDSH1/zQ9eoCyFlRe2vM5ItjCILG4RF39i0eM6wdrgwMdNCJjB1+Y+K6znV0ViwQOySVfMFNQ6sRUdcbY62PHpeaifVhh6VrROi/ccmzBK83NZmouu/LkbAm0Z7YuGNDayRkeyJvIvcWh31im9sxjcjDkywxoax3GYDb6E5CnNA6fWagan9AIfh/Cv6MyzYuPvWpKb3OJUHCPiJSN5iX3Bh07J9BcVH7uaHbAGLu2gFor+/aoQOoPCxYvULQYbZb0VoRg6PzAvv89k00WvZyYQC3kX3+xRRNQObeR+UHzEohtydEOAICgoRX0+WygpSQWrSaVCwO2VmymEb8hXyTabz4qwP9idAqXj/jvNf50/EHTXNsx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326749d1-7b33-4768-6377-08dc1be7d070
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:49:22.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5q1MxsBXrfi6mXdWcseQ1YKlgoUMLtrV0MjFOyYy7DbL9w6XVdRf9x50WqSZayVt3NCTiHvsvXnJFwE6jaN8R+TjIgZSbcHLHMXMo4Fe4+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6460

T24gMjIuMDEuMjQgMjI6MzUsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gTW9uLCBKYW4gMjIs
IDIwMjQgYXQgMDI6NTE6MDNBTSAtMDgwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
QXMgYnRyZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0gb25seSBoYXMgdG8gaXRlcmF0ZSB0aGUgZGV2
aWNlIGxpc3QgaW4gb3JkZXINCj4+IHRvIGNvbGxlY3Qgc3RhdHMgb24gdGhlIGRldmljZSdzIHRv
dGFsIGFuZCB1c2VkIGJ5dGVzLCB3ZSBkb24ndCBuZWVkIHRvDQo+PiB0YWtlIHRoZSBmdWxsIGJs
b3duIG11dGV4LCBidXQgY2FuIGl0ZXJhdGUgdGhlIGRldmljZSBsaXN0IGluIGEgcmN1X3JlYWQN
Cj4+IGNvbnRleHQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9idHJmcy96b25lZC5j
IHwgNiArKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZz
L3pvbmVkLmMNCj4+IGluZGV4IDE2OGFmOWQwMDBkMS4uYjdlN2I1YTVhNmZhIDEwMDY0NA0KPj4g
LS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPj4gQEAg
LTI0MjMsMTUgKzI0MjMsMTUgQEAgYm9vbCBidHJmc196b25lZF9zaG91bGRfcmVjbGFpbShzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4+ICAgCWlmIChmc19pbmZvLT5iZ19yZWNsYWlt
X3RocmVzaG9sZCA9PSAwKQ0KPj4gICAJCXJldHVybiBmYWxzZTsNCj4+ICAgDQo+PiAtCW11dGV4
X2xvY2soJmZzX2RldmljZXMtPmRldmljZV9saXN0X211dGV4KTsNCj4+IC0JbGlzdF9mb3JfZWFj
aF9lbnRyeShkZXZpY2UsICZmc19kZXZpY2VzLT5kZXZpY2VzLCBkZXZfbGlzdCkgew0KPj4gKwly
Y3VfcmVhZF9sb2NrKCk7DQo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGRldmljZSwgJmZz
X2RldmljZXMtPmRldmljZXMsIGRldl9saXN0KSB7DQo+PiAgIAkJaWYgKCFkZXZpY2UtPmJkZXYp
DQo+PiAgIAkJCWNvbnRpbnVlOw0KPj4gICANCj4+ICAgCQl0b3RhbCArPSBkZXZpY2UtPmRpc2tf
dG90YWxfYnl0ZXM7DQo+PiAgIAkJdXNlZCArPSBkZXZpY2UtPmJ5dGVzX3VzZWQ7DQo+PiAgIAl9
DQo+PiAtCW11dGV4X3VubG9jaygmZnNfZGV2aWNlcy0+ZGV2aWNlX2xpc3RfbXV0ZXgpOw0KPj4g
KwlyY3VfcmVhZF91bmxvY2soKTsNCj4gDQo+IFRoaXMgaXMgYmFzaWNhbGx5IG9ubHkgYSBoaW50
IGFuZCBpbmFjY3VyYWNpZXMgaW4gdGhlIHRvdGFsIG9yIHVzZWQNCj4gdmFsdWVzIHdvdWxkIGJl
IHRyYW5zaWVudCwgcmlnaHQ/IFRoZSBzdW0gaXMgY2FsY3VsYXRlZCBlYWNoIHRpbWUgdGhlDQo+
IGZ1bmNpdG9uIGlzIGNhbGxlZCwgbm90IHN0b3JlZCBhbnl3aGVyZSBzbyBpbiB0aGUgdW5saWtl
bHkgY2FzZSBvZg0KPiBkZXZpY2UgcmVtb3ZhbCBpdCBtYXkgc2tpcCByZWNsYWltIG9uY2UsIGJ1
dCB0aGVuIHBpY2sgaXQgdXAgbGF0ZXIuDQo+IEFueSBhY3R1YWwgcmVtb3ZhbCBvZiB0aGUgYmxv
Y2sgZ3JvdXBzIGluIHZlcmlmaWVkIGFnYWluIGFuZCBwcm9wZXJseQ0KPiBsb2NrZWQgaW4gYnRy
ZnNfcmVjbGFpbV9iZ3Nfd29yaygpLg0KPiANCg0KWWVzLg0K

