Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD74785B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLQHuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 02:50:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54494 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhLQHup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 02:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639727445; x=1671263445;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yz+0SW1X2O3cRF0b4S+107gHomB6tH4KZhJ4y935VDg=;
  b=Rq5sS4uste+qO2WPFNmI2iXe/r3VY/zyRRSQpcCTiLzFKlbGttEXWg5I
   i3WFFqRKzkUinVHbWRYcMtLs0r3HKajwTexzOICrJNFNEzlIeN6qwwcuN
   4+WZSt0qAZg3O5szUilJxZ1O586EAITPd4+diz2azbzW9hGYBFUtskbWc
   aX7hIQyOY9X1f0iecRP77IN7gR/KmYp9dwhN+zD1MTh/Dk9VVsml/4e4N
   XkU/BuFbLWLv1uM9iH6EiPGBnALOFev7rWaeD9Au7Q2ERMpZKvEmSrVqh
   2x11V2JuXe+R64i1zf7nfABYyuljwEMsBrYwGeMta4ReGyiCnZ/hzY1D+
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="292489686"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 15:50:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgQhNCQVBbWDa/jkWjHhypLMppcg4/pSEDmt1w0sVsTmq4vcrvzZ/MaMt5cyYPjhvoZG1qrNlkiGuYwYNI8UQLy1sP7lVm4xCzoxwEYcwpFGTiNzWIJCqXg2fd7PYUQybhYlP9g9xpeqfMqwLMMuI2hydcj0FA1w2/a6gSGJfv3o1HlYHtxUZ7gJxpExq0jq98nE9uBsgphllOVFKULL6OiPHXZS2fJtQ388DtRgBQDm/4epM5r4bYq4XB7M3NIGV53qmR10s+DsMY2E7bu4kNiPUzfcQ5UewC4rtqYwVtvLq8OrS4+EdE1oCLuM77LL/7NZ78l1L4vv6bzXN+hRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz+0SW1X2O3cRF0b4S+107gHomB6tH4KZhJ4y935VDg=;
 b=bLN/GHnC24RZ/O/ydxWlJZX4rAuM5at+VmVJ4T7wMKoxOEkmpwuS12MM3vnsz+x8UMJBk1ob/KFul4SyAA+SNiEg9zhJm0K8j8YMn2aiTS8aIFzuGcPoPW2f5g4cpYZk7rMhCxipS7RSbJoqbhrEA6+4jmqoea/sCNmAhLRPlhylAqiSJe0qGyWnJuOn/VbVwyugQ5XMkmrY841DmkpY4rmYx0UbbjGd6EMpwClsSysLm8R3DKllxzhTz2soL79rGN7LuKdZyje1R3+mTq3JAc8D+cKdyXa1YcOVJL95omCGiDFa2Lr9Vj0M41T5vnbrcEcEPtPSISNc4sDOGamY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz+0SW1X2O3cRF0b4S+107gHomB6tH4KZhJ4y935VDg=;
 b=OYx8VH1QVUSYPQbiwEo7MD9/ERT07lVHFozZvBgyQPQwTewCHjOO0d4H2IVY6E7Bp4XHslPQ/jntUWU55cAHMkwjbj6/WJF/hlCpWL70C8uLHtfHv7FRrrBwGjpLzM1de/UfKIvl819552IoUDaTXHBHHYLu65rzxmtCwHJLXJU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 07:50:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 07:50:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Jingyun He <jingyun.ho@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: unable to use all spaces
Thread-Topic: unable to use all spaces
Thread-Index: AQHX8cCfADTzoO7gRkOQsXIvZjxgsA==
Date:   Fri, 17 Dec 2021 07:50:42 +0000
Message-ID: <PH0PR04MB741690A2CA03A27CABCA7A139B789@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de78ebd-6c29-4c24-ff71-08d9c131ed79
x-ms-traffictypediagnostic: PH0PR04MB7478:EE_
x-microsoft-antispam-prvs: <PH0PR04MB74783470D469EDD6113808F69B789@PH0PR04MB7478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbGpLRA4nJT37j8E0eqsJk4Wj0TNx6Noq2F1cqc2g9kCehtt7hWruIxYaJ/UkVW6HhKchNG4NEsPcikvXxkLqQWRgkvHqhh9Te/rnqZXA2q++rz+epd2gHJcHpFKZnChRNL8GMr1rciyd/dzLqLPYEkQlBQcV21yzU5MNTjO73rCycbT1MGTbW7+QOAcIUgXxm+a6ylvB01zKaFl0T83xB2zxhxnMn7SP9k2Ftt+t3wXDY9qogZ/gUmbufJe33YEoEHfh9Td5YESh3WZxdLwq91j9Bt+jpzG9Rqzd2KeFR7ZTvbFDWlnCqQ/c7zzyWEShkVEJTXru/6q61scYn81Xq7M7oeTX3B2F5wbpIMdL2OX2DiyfyuY0J9WwFAgXTx0kRJoRTy03U4gyoKKdRb27H8352KH44ioKnzvfCKdngJfkV30xOlLhZleWoJa9iEbmiHau1ZMyweh86EZRTguKQQrr31Q46IhwCla1Ur9HABl67WuN0HMmWlqnkveB7NcCe7tbIgGsCl1NIEhRE9XxbTNjwL4sqbjoVgl2cp8AhowUvcPI2EPTlJSHaLtGYZ4l89eH+dG0vughto+AZmjl70Fq+mwuvp+o8r9VuR4NRZURy53Fa8r/OdncJUiJOcVJxoDuhRtnXUQIEIe7O+o3CdDoFBxGvmj12KRw7B0MzdCu0yf4d0j/DU+Z/O7atiIEN5ebPDB/55r+97O9yscpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(4326008)(53546011)(5660300002)(83380400001)(6506007)(122000001)(8936002)(2906002)(110136005)(186003)(38070700005)(316002)(4744005)(91956017)(66446008)(71200400001)(76116006)(66476007)(86362001)(9686003)(64756008)(66946007)(66556008)(33656002)(38100700002)(52536014)(8676002)(55016003)(508600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rgM7XriUzLea4PhbPUc+KWwIlVDfd43ELABMjT9Idw+dyRKZnABD+vzUQjfz?=
 =?us-ascii?Q?0z1orYEyTpsjjhaUH1wpKVEEvC1cE35bQmykWNEg5ggO3qxbMj2rbpIgHvX+?=
 =?us-ascii?Q?32To7oRtM34XuVLMIRltlTPs65Vuvcz4p2zQA904MLN9VZ8so2l6AeA2Ha5U?=
 =?us-ascii?Q?Ev6aFZIM5VuB2XNCG7NYJCJUrw5BsndtrTSr22AIE3BXpwCEwXhqX9oEWpeK?=
 =?us-ascii?Q?QINks/ci+RzgypbXDDIHClZ0OrVANuOIGgAf9AX/DuPhpP54OMPYMhUpWHwK?=
 =?us-ascii?Q?R8VNVey1efrVOTdIeFaNQWO5X9ivvzugA5Y/mkaeRtGFbljYIC7KfQF85K7K?=
 =?us-ascii?Q?yoKkQwU+co7iASL7+j8EGGvtVdrm7OPb/mZQec4qqq1XmF32mFh+drDYpOKz?=
 =?us-ascii?Q?ESqdXyE0EoAx12ZanHlzIoVZLq0nGtGDD8fxruYp38QJt0Sxe42TBWQxAKmA?=
 =?us-ascii?Q?bW1IXOpU4PB+ngbiQgizm7bik58DD55/Gbx8OUgcPuwx+x1nhP3MECFnZRyk?=
 =?us-ascii?Q?xkuY7ppM5AK9CTCJbFPZOkr7zzKx8qX85tcWkjg4KNP9qKGLDR0yV5f5j2vk?=
 =?us-ascii?Q?A2bv+Upv3i8wrYoFSbCv1cCe7lBWfrgvJl2J+Ju5OYoCpFzLlfpu5CpiB6hq?=
 =?us-ascii?Q?656XNOj5HgNnD5HteY5/v3gAtnEvtrZjb64U1PWM6uaSljGWL7TDSWKIEz4H?=
 =?us-ascii?Q?7KtyXVzUSeK8S7IHRoVTPcoZwrTwOUwce3MShoJxppny15f2eb6ItVeRr6Y9?=
 =?us-ascii?Q?Vx6lCiUgqsWP0o8CX6NOCHnBC+/mtr0Rg0CjzAvHT8IWC3FAb4oLGK5YzRph?=
 =?us-ascii?Q?5t5V7GYAWvFHnEnsw3Xr42C0RzyYTiliursg2vBnQEIVGozdZKMAxmPYRQ0K?=
 =?us-ascii?Q?7aj2OYtLwP3tdossVmfEJUV3i/X0DpvzRYN6OrAnRMJ1mWLlGzr+vMtpdboX?=
 =?us-ascii?Q?whCoCCQdDodOhv7BshwGEA6Do38qRg/kcVx0M0ry6nhHJpo1ZlRF+VyMjNaC?=
 =?us-ascii?Q?lT8rommfXPfahUoF9hTkQll0MGYDCmw9hOJCR4zB4SLYV+yYdfi0n1shbjbo?=
 =?us-ascii?Q?F7Wmopo0MIVhx3iVwaTh55h29ZnsgGl8OpWMqtlao+64NfItanlGZbvo+q+5?=
 =?us-ascii?Q?kCeOQigsztuAXlXaEONUj9WEV8fssQsW4G8bm1HyoeHA0I8JKoMX6geh3jfQ?=
 =?us-ascii?Q?9gXfd7Oh8Q9nlWCnGHsbfy56MJC+Dd2GIqHC0oFz4vF7aLPzFHDNRMfm6rU9?=
 =?us-ascii?Q?Ig7zjQ/W9OljKaS+KYGWIf9qNgYnuS++slKE7IDenjF83zmhcmpdeppaDWE7?=
 =?us-ascii?Q?LsKjRToThc2kBzFa29luqfF1D/Xw2xCr/B7O5UVzlUqluy8vflWj3wwOjiM8?=
 =?us-ascii?Q?alS4bM3eCFYoERLPQEICgaNFSzXk775+8vjvJUfW9Gx0lOmw2m7kHTlzLXOF?=
 =?us-ascii?Q?R2BtuLkuiiL1NfKhW4RX4xVhBoZilu4Bk20qYGOlCdeFqfpdIHeQk9tWm44d?=
 =?us-ascii?Q?cRp/ykx7eGz9udSSfgp4xkDCg24tLqe+HDFjuxmttjYlI4DH5Hr3cwOxEBEh?=
 =?us-ascii?Q?zpyELVHNdbT10S6YnfbOhsMBZYrqMR22exnVvBoPm/K8z5dFLMbLIoW+bEs5?=
 =?us-ascii?Q?UYJjzmPL5HTHJyKaJO8FmgvvGtHn75YAAmPsdD2F33UA7cf3a01OO+4d+iwQ?=
 =?us-ascii?Q?DrcEu07NNwd5vwog0bE4xesF64LO+h+zPbu4jSIV/9fQRDo/syp0dTITW6Wr?=
 =?us-ascii?Q?ZIvjIZzYbnG9SSgYTTVJE2F7IKiQna8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de78ebd-6c29-4c24-ff71-08d9c131ed79
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 07:50:42.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tqaEnhHenC1vJYdYU0lIcIwJe6Es+ZDEOexISrjRpVy/VPFLwSNv2G69VKiCyC9/X28r5Ea3MVg1O1QIixzSByXpO4bkjdcFmNwkr5FO2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/12/2021 16:51, David Sterba wrote:=0A=
> On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:=0A=
>> Hello,=0A=
>> I have a 14TB WDC HM-SMR disk formatted with BTRFS,=0A=
>> It looks like I'm unable to fill the disk full.=0A=
>> E.g. btrfs fi usage /disk1/=0A=
>> Free (estimated): 128.95GiB (min: 128.95GiB)=0A=
>>=0A=
>> It still has 100+GB available=0A=
>> But I'm unable to put more files.=0A=
> =0A=
> We'd need more information to diagnose that, eg. output of 'btrfs fi df'=
=0A=
> to see if eg. the metadata space is not exhausted or if the remaining=0A=
> 128G account for the unusable space in the zones (this is also in the=0A=
> 'fi df' output).=0A=
Can =0A=
