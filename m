Return-Path: <linux-btrfs+bounces-9331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1C9BC545
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 07:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC3283149
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF91C2324;
	Tue,  5 Nov 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hd3R3+3j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="myyoOC0W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7894383;
	Tue,  5 Nov 2024 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786973; cv=fail; b=KJm2Z4yt3VRySRu2ChAlm/+2E+GyON2w0M3oPkwmEd1oZsa9vaEiIWMjsA/LxuOFASuo6W0fw7GQ2squQqacmjCbag9wI2iSUWxSsx09FJCzSPl2sqUxZBZKdD1CqJ+6PbQ9joLVKlx+edyjAJXz1BbZwfogQsFMtNYfj2odGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786973; c=relaxed/simple;
	bh=XVMIgLIJE/aYWrm/0UlzHMni1jmR78wiw87AApTanhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWxcZ2Lsh7t/TXi9mdTbChNgjqrLrdjaAiD0FG8026+FehTaMoctNzA+wIW98szhpcVpRQBvl+s8QKg5Sx8nEemsmysqBxFpgKS87ba5z2+CmqGlPxHW/tW6lCUhcN5W9DT0bjCU9u4EFU+jnZwJrnHNZ6zKPo1PxA2GxpvS/2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hd3R3+3j; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=myyoOC0W; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730786972; x=1762322972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XVMIgLIJE/aYWrm/0UlzHMni1jmR78wiw87AApTanhA=;
  b=hd3R3+3j1bEtXJDAJd0RHa7YfKxA4vVVy8nM0Xv/UdMDp9rqjMCrqMrm
   m3lXpFbrxkLbhW5BwY2xIq9C7UbCnfN2aTvGuU9SYTvwRCjwVviQlopu5
   zWJB1pIWp70gLS4SYi3nq3CGBOxCKG/H/aG2wkyaf3VEF95Y50BDcevy7
   m/qIvYJss7BwgVID5N6tnj6BsddRS62vMoQ/cfWR0bfwZf9sgk722u6iX
   eOOvuCV8yD11oUpLZWTRHtiAv//VEhcFr/KWRv12ek0c1t2+afq3gEvB7
   vWVxR3OrrfEt9fKERJMoeCq3MTFMn8yRsQ7+6gYLpjixWg2E4ylSaYqOE
   w==;
X-CSE-ConnectionGUID: Okejn3ZkTRKy/tLUSROI3A==
X-CSE-MsgGUID: ZUeKGMJ8SM+ep1gN5dKrdA==
X-IronPort-AV: E=Sophos;i="6.11,259,1725292800"; 
   d="scan'208";a="30046304"
Received: from mail-westusazlp17012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.38])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 14:09:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKG4flV5pAanucpnzmGKvWyJwU2njvjkXS82Hny04b2pVucOsKOa5TytVX2wU3DR+bldPyydTYChleOSMTx3ztWP+CDKlO6QiEML29WlKts6/mTG3m6eAWtXwF7gFLmKgxH0L5vtyYBj7TF/KrcYEjMIjgfyazlJwa1zoLYoJGpPbICMrtarVg1id8mdWdJFjQQssBUIccrQjDyY4pmHfRrLUMTBNMNwjO4Y+UT3olTT1H8YyoOA0gxjKk/PGtboxaIdyIP1Vn8q33xPNL0zp7iubbFAzVIlxxBdQlyk2kpm/JMaGMK1YBQBG0iWs6M7juKmtxur4iKcRu4eGBj/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etPIcyLmlpb6oWECHI51VR/3JMR+ThmIXUh4zWpQIJk=;
 b=CPcKTOB2P+AuIccdVW+/QgKyfjcz/ZWMuXBVHQmCaW+MIw2Js7bZ2YR5NlRPB08Ix5TCimS2bCc1le6FoVbSYL8Rwt799QFYgXxbafrucwb7RWtUBdVJey88xof0IooScjIYTsHW+6IO5u3fxbbZU8NXUj/ZkECSESzm9Q9TkPKHbuNbojb53qpsM9vTccBZVu5tiNXkaf+vvsQIYPnjLgcgzkMXbuduCIyz/OY8tpu25mT9Js/jAGozw2Sv4neekKRAk+pxz/Iy/RModcFD1OL7AMUdYDj/VGPDvyoGfnrLXeOgo5bWgIuG/QwyNGrFbZ1WIkFQGuGZNUiDx7OoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etPIcyLmlpb6oWECHI51VR/3JMR+ThmIXUh4zWpQIJk=;
 b=myyoOC0WYOkyII9R93VuvLrxVmU1glkmYN2tRlab5IpWzLa/8L80Bf5/RL5TPu6we+E4EA+/ZpSyq/ErlKlm83U0hR+CyBd+iE95h2hOOXG94VIvKrHVgRaamYsz7+wltKTOPv/XA6GHLiF5PWNP34vQFJRl+0EL0zTSlRLnCn8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7173.namprd04.prod.outlook.com (2603:10b6:510:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:09:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8114.015; Tue, 5 Nov 2024
 06:09:28 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: hch <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Topic: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Index: AQHbLB4W1pj/Sl9DOkO09PmDigzILbKoOk2A
Date: Tue, 5 Nov 2024 06:09:28 +0000
Message-ID: <3whvw5lwr4zrajppxgwwqzlvwoismrmom54m63ozcom2kaiaxk@yotli2pvckfv>
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-4-hch@lst.de>
In-Reply-To: <20241101052206.437530-4-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB7173:EE_
x-ms-office365-filtering-correlation-id: c608c608-a710-4b30-55ac-08dcfd606842
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2nOzbGE79zfZU4Gaq8CD5jy4oYhfOuWoKSIqf7mKCFXxTQJVqBgYO7Dv16oo?=
 =?us-ascii?Q?9+oyaWWVeioCujstVuBCGdf26cyibxwd0mFFK4sV6lTBLmDF+k7mH5cn+YCg?=
 =?us-ascii?Q?AId119Jj6PfEMur8QttVycLHoFKHhSV2sR6V/5mLy9CDvEf1+ygfSIzl3BuE?=
 =?us-ascii?Q?L3A+Yvr/WXNMDRnqJ8MukLxM56UvOES54BYyTsE98fncOYv4ptehssZOKNkB?=
 =?us-ascii?Q?tcHk/v9crU/bolNwv0e0ir38ThUr4cRpezVSwO1KkziR9lTzXzM31t1m0wjH?=
 =?us-ascii?Q?Q71yV1oUCbB3zZ3zvNpdOPzAtZT99S49r2xJNughyyPC14rBJ86NEeeR1ADH?=
 =?us-ascii?Q?NBVnUWuWkZ7HHeLJ3xFRUAy3IrWBwMYjtY3x5WebVTdWq9ex7JGjwEzpxZpV?=
 =?us-ascii?Q?C698a+rYTWN4T+h8lWMrp4XF6khQeZ4hABh7DFQhjtWBqutrrZKIeCewyXqn?=
 =?us-ascii?Q?VjfHX8BnUFp1Sgfrb7VAu8+bIq8kyBh2bSJJJn+3cDxPGyTlofz0tBgbXZf/?=
 =?us-ascii?Q?a/WptSCq/idwN2sHwrr4LvRr8qpgCSC9v0fnOFnFn0AblaIpOsh3MTPobJCl?=
 =?us-ascii?Q?Wip7lg4U31kWJMbfydLyXAN1FHlTKW1L/Ag0VqOVQA57hzJ2ewEqWv6JUIZk?=
 =?us-ascii?Q?5G9I5Ayit9wcvLT/3810ViXP5ufzeFEEb0/Z27KMkVvtvz5wZ2mjEttCB90h?=
 =?us-ascii?Q?GSE7V8TPr1od5dAYrFDADGJtrxULY9OrY8XdoV3bu4ekw3eDAB6e/qcLMiwi?=
 =?us-ascii?Q?fUa4Vrmo/NkoTIRQEJ/aGgzSa7zlVjgBM6cnYu2SQh5I8zMj2a2VbPOXfSaL?=
 =?us-ascii?Q?78cP5vmpTAapPrEy5V6fK6XCfBkv17/ar0Jg24MduL3DTcuvDAM3tkXstZTr?=
 =?us-ascii?Q?Lql7QG402RUizal8wfPH7kTM0cRFxGxg3YZ4c/hQLFpYIc7l2SYXYCz6cDwi?=
 =?us-ascii?Q?hCItr6QR0hOohOrvxS6whJMECm8tiUo/84Xi4dq/E3zon1/gvzg89jAtZpkk?=
 =?us-ascii?Q?th9MOfsteez7jjmiKZvAaGN9/B6hApk0FBCDMjmRZf8Rp1WDBmZKbAqQ7CaU?=
 =?us-ascii?Q?Li/kC8dYaoXxI+38nLVEZQm0EfdGDDDwEl7GD1AulSQXOR6ygU2A8pxjXcbI?=
 =?us-ascii?Q?fCrueeS6Bpic0ySoUHZ7WHnGJr6T1Eu4VpYL+fXycRFYqcxOuPyBx1FcSiww?=
 =?us-ascii?Q?RLFQGswEweU4EVqCvAPKpa7eVhVrCpHpYlLfOJ5I6oFJF6H7vbDx5SFOPbbv?=
 =?us-ascii?Q?qTJn5Mf3kxbxpelW77MPhVJB5ZNWtdrxIoGaDM1idPQ/mJj3cl8qBEK6iraQ?=
 =?us-ascii?Q?A/AlvU2KNlIvS+tI/rk7VnVe3oSr9bbNihyFWBzdoUBmHlZ3NQ19ms+1yIMk?=
 =?us-ascii?Q?sOq9OBE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3KTtKK7tQY+xmWqFTV5jtWbHCt9s3JSWy+MgEjYN7R9Py1UTUeoK6yfCrrS3?=
 =?us-ascii?Q?lp5Clkqw9cgu08IBrkEs+ECanP5n8jrJlkT9qHq3MxSphJAteHV6scG3bhqg?=
 =?us-ascii?Q?sKMMD9laAtoO6+QkerafyZCDBOTtMIL+cJvte/WTTL+AaTjJzMh3o8uqJJOF?=
 =?us-ascii?Q?Qy93yiWi9U+BldHOgiC0JwEvUrXghtED2zwVmRI8jvbYEWIra1CqI/LpxZwF?=
 =?us-ascii?Q?+sEHaPsG07AIq8LLwrLyJ+/xP/yQY6EIo3qaQac2h8QFycIVblajtrZMLQP1?=
 =?us-ascii?Q?uebDHi6dDCtk4cEQDd/qjNAs3DnvjmHHy57FHzw9qWX8DyyD/8KYhtC5YjKc?=
 =?us-ascii?Q?CgbYVzz8Orqo6NVYLUbcLVdLOGB1x4D4cqP5PzFSFPeBULAsKqVqVn22KNDW?=
 =?us-ascii?Q?vefijgTdkTxk84t9hm30BZdW8Y8W39lEpe495yzuYNzGA1+HrIR5vtAaKfgF?=
 =?us-ascii?Q?UahDErxyPI/IqcbNw//lVN7/QT/Ig3ugS8CGlzBDpjtkRKmibqK+wpRPEhFP?=
 =?us-ascii?Q?zAiZo7weMySNjHhGLEqAJ/EciusTNxLcYpXTW+rT7jmQl+s8Gzfld9PICs5r?=
 =?us-ascii?Q?Bgli43yV0K17hePhEz5KQsbeUuQb8fjdTlH+ErofiVRaN34RjtZNgRSqPNW0?=
 =?us-ascii?Q?+U/jdMZIRKiXjKN0dyRqg4XyA07Rrwbof9EIFK/uxeEG56eUwMoBwDRS9h8f?=
 =?us-ascii?Q?0DeHmKiMlRbJt5A8BOnYCRZWQcS40RVdDDiQ8VcXlUhwvj7mWchNi+xyiC8D?=
 =?us-ascii?Q?HgQ+6+6rh0sKcNP5xeDj9U+EbzWhjIcyWoiT3nlzYvCNR7runLhFPy9Vvpfe?=
 =?us-ascii?Q?ZfScnefZVIsdPi12KxqEX2ob67veOIcFtmiueNlnWjmUYaVL1pK5YTvgvuI0?=
 =?us-ascii?Q?EERN4nx5HnnQRCt9xIAbU5Bz7fgdY/nQxnqCfFwcA1ajr1C3/nPUJCq+e5xJ?=
 =?us-ascii?Q?6JoIOL/HULmjgQ+0eXJcf5DWmk9OmoW2V8IXUsocjgGmtc2oF7bb9mmoXUQj?=
 =?us-ascii?Q?Ch4OKEF9hwNr3Eoau1htjpfr4CQrFbNAd+2e2ZWj/Hw7admvUdJ4MDH8WIWJ?=
 =?us-ascii?Q?VGHJtXsxgyNOhfMXa+10vJIv6HDwWZ9rLCnZjflO3Sw50mHFAfsowHcl6VaM?=
 =?us-ascii?Q?3j5IbYOPE08ToI++Lfya2ga4gFV8DxziHHtoN9QyPGgwqtZT5eNNux1kLejX?=
 =?us-ascii?Q?dW/zk2fB+Bf1vYnZYQkKqLf/mt0cJBBcUjVLsqRj0u1IkdkjskxnrwjThxsu?=
 =?us-ascii?Q?hk7RyU8d+UUDJhoLVBQMei5UjLUFb62KqCW+klZx9FbZ4b7uqEmdpoMYJpMO?=
 =?us-ascii?Q?qFEaeA/XXhCAlN+hIVM4fcgxt++7WAczpucHvMDuqc/sk3NsCWHWTnP/x+4b?=
 =?us-ascii?Q?RrODqV/revzXsMWm3PL1sb9FHIJ2d6/MEOkBOTc5UbX5JSN1azptJEjvov5g?=
 =?us-ascii?Q?GV0T4+XclwZuNUwXAcyDEGTFwdrqLMrNkNabqfjxFH/dAEMrrBaX9JT66vi1?=
 =?us-ascii?Q?VtM2c4MfBrxnMesRHgyhGuHDSKprX8zDt3m/27QFk+GLWdBc81hOEEbXEcxS?=
 =?us-ascii?Q?uMj+5JasDeA77Z/BU3KQhRWUW2ZVuGDSiyfr0JzmGg+V70vBzG6SFvfH2hzF?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10A9265E51C1AB40839E005E140DE726@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C/hbdF5UlQYTG9s3rdQxymS1jw/vuVdr8iHdOMKHDUCM73VEw6W7AT0Eie+ZuqyH1GwRusmO0ccuO7B1iOME3Jy/xLXvL/nh/Dfw7+9YQiZ9wDG1ilNgSSARfVqmm+MSPYEGUf9yfj1rVQZy0vBt+SZHOycZG/WNNOVc+1UFW/fXkjW81L4sKR026NnYlyu66Qk1xffFjC9Z+2+jdHNlDeLFDRKOgft9HjYXW9KtIY7PEiYHFqYOCyRG309a9vIuQLRsCyMAn6VNKMgKHjLfLuhHZuPQU0iYWZrzg+WQh4BfGmkrMUy5eKQbZP7/dQ4A7OmIage/wMiJkCYFyBeDFcF4eDTUN7Ait4eXwbaYBjUHiaP4O5GFQ6GXgKIFbHsOfFV84o8yhzLAscByxebYGJf9/Ws7wHTR9kupSpjOCMLD/WCsfT7+ZIxLtl88ylyxarHMIHPKgyiojsn1AQdF8xrv1+C9iBLuw24zWvXf8bdaTXKUsEv1UvT4iM4B6Z/jUl/esHh0xwv98lzY3geN5yFaKDwI2LcuDmxIaVAuDuGNClfVrHYK5I8YVFri3Hf/wxTE3zzIZkiLmGTtAXqDPaZhqA2I0SisaDV0tN/930bVyIbc385aCLH4WNf8Jhlm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c608c608-a710-4b30-55ac-08dcfd606842
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:09:28.7171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdxvkRq6CgCiTJ8bvom9HoApyNzMq05tEJ5J/iHZjwvzFkfacUMX9Ic0omR407iKSLd4/SVr801/kVZ45ITUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7173

On Fri, Nov 01, 2024 at 06:21:46AM GMT, Christoph Hellwig wrote:
> Otherwise it won't catch bios turned into regular writes by the
> block level zone write plugging.
>=20
> Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

