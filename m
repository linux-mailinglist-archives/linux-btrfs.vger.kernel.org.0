Return-Path: <linux-btrfs+bounces-2072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07829847073
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B33A1C24561
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6815BB;
	Fri,  2 Feb 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEdDyKl3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l4lreQEF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FA15A5
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877498; cv=fail; b=L8oPeabxD2h76ERIuKA27AJv0lHueMpOYxqy8UO21+bSf9E+8X/qQLTc3wvgeYYn17oGHjNWzqCiOOrCc6L7WIER6hX7EGfclIjjqUZ5cdSDAfL1rTeo9GzcW4ALIS2Fkay3HmJnebgqNy4ztQ9KTZGGvm196+hhIwO1fk7iKN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877498; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBBiuCCFZxCoPMiP/eJxidV4RUXWZMBR0ed+SeRPngArjJYs8PDwtjBZ9boWBkfNFZqu2wWfnl4RB/yI6LR4Fpw6LweyZmu44+cJ+ykaQ2Cz7ySGHlUexjnIibeCPa9Irz7pK11br3Jg9yJ+zzbX+4Brv9j4WbJOggwpHcXfHGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XEdDyKl3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=l4lreQEF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706877496; x=1738413496;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=XEdDyKl38/JMUhhlbqXyvE0Av0pm15GbBlrGu8F/PJc92hy5go1DQBlF
   cli/3P9U7LiJeaaKKEWKfkw1NWCaH0xCOP8DhzpfC3LDwzfsA9JhhRTSN
   40GcI/CYBvHphqVIy4nmpWj543i1LyI8fhjDTkmpAlW6TUsoSJMJ4psxF
   wnd4M1tUIyza0ev6B0kP9aI55QU4ZuvqCrGCLej0n3QO6vlRUrjg5r9Gf
   amTbiEW0g13cvM5RYZROFUP1W3+rxb+uu19B2I5s4SNNo29xXFTZgK2NW
   wd75zegERWMvtTmR53CR4Nq+NeHFIXf78iorN+kaS7NuQX9gCnk4x3nbf
   g==;
X-CSE-ConnectionGUID: 9cmarsdfSjm7wYYfSnvkpw==
X-CSE-MsgGUID: Ozq8fwLcRYCKjN+JF0lILQ==
X-IronPort-AV: E=Sophos;i="6.05,238,1701100800"; 
   d="scan'208";a="8594278"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 20:38:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrAfbU4sWq4KNR+hR6Mo1kf+u8uxUqfPGmGO0DrasTeM1UWCz3WlH3+wmby56YH2hwPrR3YiEmR4M+psHIPyRGz+Zg03P+RiSvvQnZT0++Ns7TrXEdoEhoSnBlr8gTWF7K+1CPKDpkIZ91YgtpWrkOFvz34kzkgjOQp8kJ7O+t43itQLqr8PBbuOMuiZ+9xFc1xm7/NkPOxIHwJ3/+RWJkYE4Waccr+U1rund/BHyjGp6QSvv+qylRefvsmzQAvp1VpvV5x+X1H9qYKMaf76x7j78St5ci/t2DV+O9NBhReK+pY22iMgnQ+WIOOBhcH69XHuHl68/b3CUw+Qam9TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=a2x/JVbpio0cTynRwZHv4RlBlkLWDgKF2Hzj2evbf8lq+ha9AdVw1iIKlQOrMzlzJSoBC4RKIGDwPlCvSH4iEgoD8UiWbXdp4jjCrKgHs4yXohs/yN96TYekY9g4TVgZg5RzBe9IA7XM5OXux7AmhOp+9fr9kDnXpUptETi/H07Nt4646CBudviAEtj7yjD2MOT4rVivHjusFAasBeJnxqMRQgrcCi5nPVl6NBAIK0zatlTFnmYnIPMf4eAPjgngzWSaKzjzUKXOlrcYKUHV1xPxI8ELYALKtTWBxW7sCZcTLX8Np74l+UodJGs97USN7mVRVozeqBkm6tMC7MBThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=l4lreQEFCp5AFPh2IFYpIwSpDkbv/G86GGM2c7SHE2Wt0vQ7vhPw4e4pVCA6iDiHCMseIp3mw/Dyg5cD6v9Rm2RT9Gmg2LygbiW24pUU5iavR8pPNojd4ynM7D2dSg6rnFkOweWfxfKAt7XleuuO9dQkmpI52OEvI3cXnmqSO44=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6972.namprd04.prod.outlook.com (2603:10b6:5:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 12:38:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 12:38:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reject encoded write if inode has nodatasum flag
 set
Thread-Topic: [PATCH] btrfs: reject encoded write if inode has nodatasum flag
 set
Thread-Index: AQHaVdKZmaEs7sGYGkCvBloyY8e9r7D2/bEA
Date: Fri, 2 Feb 2024 12:38:07 +0000
Message-ID: <1d14118e-b24b-4d8a-9d34-5b91230a4bd5@wdc.com>
References:
 <5e9fccf6a2c57b6bbd28427ca864fe838b43d394.1706876439.git.fdmanana@suse.com>
In-Reply-To:
 <5e9fccf6a2c57b6bbd28427ca864fe838b43d394.1706876439.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6972:EE_
x-ms-office365-filtering-correlation-id: 4d57207d-b38c-4c85-f50b-08dc23ebcea0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HHcC2ln4DuFQspLC/Mgmtpk4nu8xNT+Y2FyhENwPQ2v7HheDUEtU7AH85vVXWMKqOp8S2onciyqre2/vQX2mWMahM4D7nRsENF16rienqBxBl4zMFt7Vsl4N0jTXW526tvMqvZsT4KIGfpDj/NC7joIkG11ksx/3Ly5zaN8BkCAbJPLGS1FnImBXLKZTODItfRlz8j8w7PGAmBNmWLlerPmrId1RVL5wE92znysyIDnQ6v0Arp7QXx4dGklUne66vnjCmzmN7drizyruoi3mG4tX0bT3sfMQA4ntIKRg9QzKu5Q3W6lounQh5ZjYu73wIGuPBTgpA6VyRmIEpUM/Kvu9Z2ZqBXD9Q4nso30Zd4KybmytzjlJz1+yseFiQGYT8DkAHBjFFZpEdmHUN2VdG0R0qxWCuG63GRDEMPiVcae2MHy0Toko7lxTP+nLAAL7CQ/hTVikLa/whvQ+NLONnV/F8ExINFbTIh8UpyL45DmCB420hzFINczwf/qjG+T6jv98IQ4L7ti/Y0yTf8D/4iXcdKbYzS1G0y3NIrVjOUKlyyp7usiHNf1oQUVn/DZwYIH6RSa40qBnAI2kaUcJ0XZ9UZvzQOd5ndexdK/354wrynxcZlb3PdiQZu2TPg1TXjgeXVaihhC6hcI6lJ3xf0Nw6uiaB9MyGAmW01v8kQfKRoljfr449GWCUlFc34ql
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(38100700002)(558084003)(64756008)(86362001)(82960400001)(31696002)(41300700001)(36756003)(91956017)(38070700009)(76116006)(122000001)(66946007)(110136005)(6512007)(4270600006)(2616005)(66556008)(6486002)(478600001)(6506007)(66446008)(66476007)(316002)(71200400001)(2906002)(8936002)(5660300002)(19618925003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDAycEhQaUpnMnVTcUtNTE9Gd09iVWxtYk5lU3VzVysyTlU5Ti90dlVBcjVQ?=
 =?utf-8?B?MEpuWDBYSkloTlZud21ZeHNiSkVlZmduV0gyRHVpNVVzOHVqV2VFZW9mOVdh?=
 =?utf-8?B?cTdwVlo1TXhtbkZLci9ad1p2ZVVsbU5NQTNFa2JTanNuN0E2cHA1SU5wbXA4?=
 =?utf-8?B?NStIZkxlcndhcnBQT2JYQzJSblkvWWxyV0crdXB3cFRzNEpwcjVpSXdlZ280?=
 =?utf-8?B?RVdSTDB0UHpiSktEMzJLaFFneW8yUlVnSzBxMHFiMHRIYjRjcUtTTGh5VEN5?=
 =?utf-8?B?dmtLeTFxQWMyc0tJeEJaQ2YvemplcE13RjJ2VHZ0M1didnZEZFNkWG1WcnJZ?=
 =?utf-8?B?bkx3MTdiWFJOYUIrZ3FXSUMyWUZrME5EU3NBaStOODJVanBXLzI3Zmx6THZv?=
 =?utf-8?B?M081SGpZU3Fhd2Z5aXBzU0g4c3FJVm9XY1VCbWdTVTF2a3cxalBDeW0rWmlW?=
 =?utf-8?B?akV2b1RNODd1M1dYQTB5SURzZUwwTkRqMzFjZEo5VTFNbXlva2Q1OFRQS1dZ?=
 =?utf-8?B?NzAwc0huUENTU04vankwS0E3Wis2QVh4UDN0YThqc0c4TUc5cGZySVVaUHpR?=
 =?utf-8?B?WmRyUGxjc2UvaXMwK0N0ZkFPbnpxc3RWM3JyWmZ4YXlwK28xTGdWQ2RnTFhB?=
 =?utf-8?B?YkZodEJwandzdEl4NkIrRkxDNUg5azZHblM5YnB6T3hlK084ZzZVdVJlaytG?=
 =?utf-8?B?QjdrZWI0d0hCS2IyeHdXVE1iL0xtclpOd1lPeHVhUVZNS2ZNUi9aWXJZWmJv?=
 =?utf-8?B?ZS84cjZMVW1xUWJEMXFWU083Z05RYi9wU3kwUHBxcVI0VmhuMFE5VmhWdVhW?=
 =?utf-8?B?ajB3WVRYcHZmbHkvMTVzVmYvOXRnL1U0WUN6am5rbWI4anBPUlQyWXhvbmZK?=
 =?utf-8?B?bkFIbnBYaFR5a0oxSTBaYXBsZEZLWGlYQWJsM0ZYa2NlQnhZR3NibGErcTJk?=
 =?utf-8?B?OGxYeDZ1RHVoY1BCS2FmajZhODlEWGs5WTcwUDJyV3hWRXBDOXJUZjlGVlBv?=
 =?utf-8?B?Wm9aZHd1R2lEQjV1dE8zQVF6emxUVE5SMUhrdlNUelNYcTBNenNpdm54Mzg4?=
 =?utf-8?B?Z25oQ3U4QlVRK3FCMkJMUTJVd214a0syZFpQbkZjYUl6dFI3TGE3V2hqUzkw?=
 =?utf-8?B?WmRER0Q3TlRmamdYT3RSUEd4bHZBaFdlWFhjcWREQVhRY1lhSEt4Um8rQVJM?=
 =?utf-8?B?Zit3c042eStvTmZDWnY2SnU5dzZWMFBDaGZicTFncSt4bXIvSTQ3YlhCRjVS?=
 =?utf-8?B?QUNQV0lkZDRWMFNCOFR5TXJURWxOMWJ4NmljNlNPRkErcHNESjhlMDc3K0dv?=
 =?utf-8?B?OFlFT2pXay9CdjRZTnJPV0dVWTdiMTd1b1FuRW9oRmw5czM0WFBBTVpnNE9K?=
 =?utf-8?B?a3BEV29vOEFFa0FjR3FQTDhjUzVIdmJPUzBhYm1semlJanpFMWJ4VHpnbTNw?=
 =?utf-8?B?b3J2aG90L1ZkNnpCcFlWcFNzZHMrQlRlUk9qbnpsNURJODhwQk11YmlnTkVS?=
 =?utf-8?B?MW0zU2FHMmJyd3R2M1ZjZVEzSWF3eTlZcW43VU5oUEdpZkZFaFRPcFlWYjdO?=
 =?utf-8?B?QUtwbFM3S0xNdnVsSTRpVmI3N1FnOFFoK2hwS0tWT01VbTdxaSs2dDdkdXF5?=
 =?utf-8?B?SGpCQ2lJUS9DTHZidlBoSDkvY1ZGdHR0YmJTbTdEWTRPOGU0SUF4VVdhVUVz?=
 =?utf-8?B?R1Z4QkFwYXRJT0VQOXl4ZVlycENpTjI1S2tvYUowNGNEOGRvZnp4U1VjeStt?=
 =?utf-8?B?cEkrVmViSGNEMEtRV1diSVhUckVNd1dBaWw3T1pHVWtCVkxFSXl2ZTEwNGZv?=
 =?utf-8?B?aVdCbkk2ems4WDlJdXZNRkJGQlFOOERVNkF4Wk8yeUIrZU5VSm1XL0VuMTI3?=
 =?utf-8?B?aTNQRFovdGw2eEJVVFJ6em0yOHltTmlZVG43VE9ZYlpIWDkvUFlodFdWMUZU?=
 =?utf-8?B?b1k5NVpqUExJZDJYUnFKRnJ6U2hCRS96M0Y3bkxrdWNUMU1RWlFHTEcrYW5m?=
 =?utf-8?B?bkNCYzg1OVJGMHR6TVdlLy9XaUNvdjd1eU91UTQyK3kyUU4xa1FudDZDeTdI?=
 =?utf-8?B?Y0x2V3Fqb2F5QXgwQjgrL1h6dldOdFhzc3cvcDlTaGtNWGZ4anpHNGx3UW9x?=
 =?utf-8?B?TmcrSyszZEQzdTdGc2ZPaGw2VnZxSm9uV2s0cHBTUHNQR1A3bmVMUk9xbURy?=
 =?utf-8?B?SUlIN1pYcUNHNVUzT0EzK2p2dW5nQzZhMmhkcml2ZDBsMjJVUFhIYnFTWmJV?=
 =?utf-8?B?RU14MFR6dHh6UHlEZXRWdFhoTGFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75938305329A2C40A17A767106AE4E0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dFJHKYUUKBp9aOab40du8YsX4NK+HVLE6m+Va1NEBdXOf6dlXRMdxAqAovqo+nQFV1o1JeX3Pi96Zpd7n1IiDvFUarG8SBWZIt/x6oDVfnj8ZBnTIkkEhABu1qR6fhRofNMYkQR9uDRNABvgKniL3ruA/gZfB/pXU6xu2knKA7emI8M3ctheB08wGpKIT74XMpc9K/iBL50q7S+QBhtTsFhaVGTNR7sZTkg1QCYfLVIm3eJ1z89sxDdykaDLB3GG4C14QUPUgF5JbwjxfUapQ6iFTMmNOBf8chYx+j/2HV+FdL26BG+zCsg5ccNVGmM3VfIGTnfYLDsdfUx0EPLoHhLMtLQtgKGdH/CAoShSD1qCktdO3iDJdindMJEetN7FJfSVn3mESCPoH59nOjufdY5VVXsYa+Nu2cRDECtSPgUHnhBTBtD1s7z0+PoNtIS/d5ehdcqZbX2ZDTB2ns6emvZZlz0yiMgYmSiZZz3IxXaiXDK9m3WpGY7yMZwqqW5YVDji+mCQ+a0SuoxvmYENA27bgvAZvzIwAVsnHMYqkrjF0wZYdDD7QMVd2c8pAwW7etaOLl7TO1p/hUk7+MxscG8B+Z+zXSnmQfkvDSUZf95dFTFSb4fEu60rwl5LNiIY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d57207d-b38c-4c85-f50b-08dc23ebcea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:38:07.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZurVCTUA0jt9ZG4OOMQl6VcEueIfbhdl1CVMMvOdjdmj+f5N/+IAxIz+cXVHkAN7pIHPe4R2H5puLmcm2Gr/FvKWO0ptJPtbD8TbTBWYhno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6972

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

