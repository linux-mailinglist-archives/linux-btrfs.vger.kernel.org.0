Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557BF4191AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhI0JlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 05:41:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34109 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhI0JlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 05:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632735567; x=1664271567;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j0rhcicDeYC3NVhDqAyWoVidfkufG9iv57e84jwIvcY=;
  b=Ocqwr1jBVzVzvNR+TX95mN/hNsUAYWH1uwEjfWc0K9D29Cem/VIW5/c4
   C4l8eJDVmqZXVMKl8iqCK4AAc02HrgXKyYirowZl1rhPJDTzVOgQLfWV9
   ct09wJakuX4b83W5Q2u84WAz86SAxWhqppo2MoT7MN7U5iKDJaZ+SLxEo
   +uKum22hga8nCvYklOwAOA+VnvnzMeYq7ETm6C4ABm5wwxbwHXDlxXjat
   k5Uws68D2gW5Admjk5z2FvsrkWpqR8hpjR2IIf3aoLisf3b3Q+VliWmLu
   kZlV2huMy8al6SF2p9oXh1bzf2AVcCpTUQ4RhfC7ChQdS0UuD+VLJLer6
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="181665397"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 17:39:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnBmL4A/qxt6MIyrj87nHncVEVYkssWUiKG7qu4RA7atSoNBgRykHf87agZgC6uduqg++BTbEXycpv8j0OiVijcQIe8BhM9kV1kkgA+rZlhud0p+8YJ5TcJH+QgWNpLCUEreHxCgN82zPWlAHVOb3oOXtkjhVjPkih97IfCZ14bKhxCI26YcFZsgusjlAspXlbJcnquPX7NH4lxCjj7U+OZIVrwP26ElpGmiEJs3j6Wd2cRMx7hB3pXDxwZ3F18DyP/NfW3oXh/5wNhSQmWvN1e+iP27YdEnQMknbcutvb/oZBlmHzdk3w6q1AL35iKk+ztN8PnoE0oAbqo5hR+Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j0rhcicDeYC3NVhDqAyWoVidfkufG9iv57e84jwIvcY=;
 b=kMB2MnA8fgY59qLwoPS3ezn/W7TcsX2M2nDYZ4eoLlL4mfpZxq4c6mdSn23xwPX1fP4p4J27k6gkgjqxLF72LZwbg2yifyS/GqlAk4YFarg5QClKVkHDNY7zEVtLXiWZl8PeEkX/tzI5Cm2ZQc32cIyj7Tndvu/JG69DRGs/cto7Os8BO5pDMkb2ccgI/kRunjOtyIskAp/LR2Tpo/iMuwLFqwmjLI07l0Rmx2ZbLfayWAyvPCug2xa6nhHHvWh5vI4kiSqus2sV/IJ++PDSGXGcbwioFRleDqsLNqFzJKqJb34DZaPhT/CcpXS+rXh+6SWqIRSLLHMNuGenslZGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0rhcicDeYC3NVhDqAyWoVidfkufG9iv57e84jwIvcY=;
 b=Qlj1C5zHpdJrag+vKDGxEf7EqcRKhmQn+tjp8DfDbFz8vXc9pgxTV/dMPG1s4vTg/0DzLUb88Ui1nXtGYo+Z9wG6olbeyRmw7szg3eXVaaYOPeVhMdVYRt7CF7imhAeCbvU6ItyAD3cqxqVeMHmrFm8vUuEFUjq0qs6Jpak3Bas=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 09:39:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 09:39:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/5] btrfs-progs: introduce btrfs_pwrite wrapper for
 pwrite
Thread-Topic: [PATCH 2/5] btrfs-progs: introduce btrfs_pwrite wrapper for
 pwrite
Thread-Index: AQHXs1Zr5tTRd0flDkif8PxG3NyyUg==
Date:   Mon, 27 Sep 2021 09:39:25 +0000
Message-ID: <PH0PR04MB741601A0D9D04434119EF9839BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b079ed9c-7858-4d8a-4232-08d9819ab1b5
x-ms-traffictypediagnostic: PH0PR04MB7176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7176653883A07916069BA8B49BA79@PH0PR04MB7176.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0lb+s13dO4w1VHkL0WLeG+kU2QaIZ5+HBFOkJScvCXChv1D5RlQqWgVi/Hfhg3cILF3E0rSdMUjqaXmtJc9F4DWAl/KWYDpmOAiGmGKij14L9T9W5fNFBZTov8nSTjxkRxN4ZU0OC4coYc9TU3i5KG8r9P8SKlFbaLoQ+RflVw1/3+xAy2d3XydPPUSFoC/Bg0wF/9yX76tC0iSxDq8EBLiXT+QQCuBAdRIJ1wKTg/FucVI+buQIgYyUtrkjSjykN7bePZKPDtjyuu4KZqx7tiNiqMdk2x+5V09MjUnaOUVd5i29JCIhzMtcPqHz/Tpp/OSrdSt9M2ws04hUeDwYTeIZXnTzDyn+YnOqbRl7IPBwaKAf/Jfw4rGdT/aEl+2yqLXP0OnvTbfMC23Zy9OU4KO5XpG1c8fpYoRIWMzxk0ywGZg7qZm14UxCK8MeNrxJ4JW91JvsqK4PkQuVd8XP5b5txHz6C/njUGjMBuWggT/1LF8/lAKX3AgUrINm4zLR6I8fqIrKpfWCEu8lNbEAv50oI8M/1+zTywTwe1fUBh4QclwrRfTgceYgLTe1XzpulJ9RaJwtkQPT7OwQVha7QMg/jescdJBbTfZyjkkTCuWj3ZjGg9YWu1B3zChEHVZAd3LQ7lacWcfyDwY0hMUKDFi054E0p8VK2e6WYFfoSUJAus1HnmPD/2kRnlovt26vliIgJzuQpWJ4lYDSVidyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(64756008)(66446008)(91956017)(4326008)(66946007)(76116006)(8676002)(52536014)(110136005)(38100700002)(5660300002)(316002)(66476007)(66556008)(2906002)(558084003)(26005)(7696005)(186003)(71200400001)(508600001)(122000001)(6506007)(55016002)(38070700005)(33656002)(9686003)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o7uI54Orqa2tZtWl4XZcsfu+e+odE1z+bfc/yda8apKOSQn38h1H7kDwg4re?=
 =?us-ascii?Q?qK146orE7NdCrrGi2/3S0uxSzBKpTyksVSOfkMs02aylaBn1Ew12qIZqpl0A?=
 =?us-ascii?Q?CscmT/1iBpMWNYYDmN17RQnkPWcbZGGBfUtmUpb0hfWXb1tiqRd8Ec34zUgT?=
 =?us-ascii?Q?/cSM0/cK04/JkkbStW0YJ2Ku5ehNGJYbLDbO0VX58uG3U+3IpYIzF+SwhuwQ?=
 =?us-ascii?Q?yNFPQZCVVRqAJ0HsMCHh/fhEFdBnZBn/U9WUamShVZUh3hz31eiWNxOs2wpT?=
 =?us-ascii?Q?ZmHW8Gq4xncCUtjQ8dHJlkDHdPWb316sbbN9Hxxt8f9tB41Z/PzEtLxlgVZ6?=
 =?us-ascii?Q?XTiNXBA+MoEnGGUYoldAiuJsPPiXNiQ0moHaPDiyGikDSKSQWUukrH0TjBgO?=
 =?us-ascii?Q?NN1qZZio2zA8duAAiBYfjWof7Y2tIBFni11RXWRwjrrzhS2D9bzXnJpVftGN?=
 =?us-ascii?Q?hKMIQ8fRWix6nv4WWXHtNNMg5owVjzNBZeon+eALz7u4TiMJDOq3A+JCFCiC?=
 =?us-ascii?Q?eVn/ZThpED+VljNa1ydvIkWrUPbHCigGE30i1sKNdpfUcqvreg3xidMY7hQf?=
 =?us-ascii?Q?Jzg8AQA26s9ZPVZWf78GiD5AQpnaeqvtsxqRfGgV2imm992aZ9K3SmanKSH5?=
 =?us-ascii?Q?RXEGM0Ed7VG2OZej7wzowjvYpHQghY9cPEROymr+B5B5kXnz63nDVHN3p9gV?=
 =?us-ascii?Q?2lAehL60Bom2+I9lbpymDpZ0OHsTCn+gi5cAFSDuWsX/T3PhCcL9j/0DSneG?=
 =?us-ascii?Q?4L7JYPjZEOEC/5U2y2XATBl0sNXbYbQFpaIsbN+oY/H2JSx8jrxToNG+sNWE?=
 =?us-ascii?Q?LzDJ+bU4TpF9QynW+BYNV0aDiv3mBc0y6K+A+UJOqFhcHlhJx18z8hw8tpFG?=
 =?us-ascii?Q?076PmesfGU5oMAURe7vQad656DWi6oLhJgrShyxf6yjcqI65biVspSmzfTpb?=
 =?us-ascii?Q?afgp9zzQfkapQNLKCLY7OJkhzCx2ilIxBdd/9msJaQ5tP6/NpSeuCDOQ0G0C?=
 =?us-ascii?Q?dNa2Fzwo1j+SRrlD5PB+mt1RgNNRjx3iR88SKgHiOmtQ7juvrrlKccvQ2zg7?=
 =?us-ascii?Q?YuuuLjdx/TtjKhFOF8QVQAlt9ZV+JVxzp4ir4P2pDqP9P3l8QImd9rqJB+8a?=
 =?us-ascii?Q?HbNG1RpN387cU7JRKE1/DPXIkkRXahzNwPhX6rSn4MXuXoMOyKzm3zxRg+Nr?=
 =?us-ascii?Q?jNDvZJtEqLhvEKxhMhM7lZw1SOTQHEZltaUree1BsFR7ykXoK3xW/MowEPOX?=
 =?us-ascii?Q?B8Kc9epuYJeVctHE9ifK8DzdEh8dE1ThA5WXywkhoY3+WBgHvy+fn0diMQhd?=
 =?us-ascii?Q?ILNbCjATRwkX5voreRDWYvZj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b079ed9c-7858-4d8a-4232-08d9819ab1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 09:39:25.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGcLGUiPbUQ130XjwkcX6oDkSSfAhiRgy9YC6qxGq4dbVc7eKvfJvdXaQTd6skjbZOlhXZDpv4eK2fZKDgn6XTvhMTaU3Me+8d8mK0JtJgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/09/2021 06:16, Naohiro Aota wrote:=0A=
> +ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t =
offset)=0A=
=0A=
What's the _pio suffix, posix memaligned io?=0A=
=0A=
Apart form the question,=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
