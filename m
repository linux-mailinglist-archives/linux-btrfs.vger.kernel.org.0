Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6951A1FB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDHLRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 07:17:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgDHLR3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 07:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586344650; x=1617880650;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fGf1CQVTfBr1/sdRumE7KfFF5qOCAoX5RkqtjbcZdwM=;
  b=cp8NY7zwDR79ygBeUmHcG62UTN2wrR1Aeb9IxKH0ljYRoMdQSgcPROEj
   fWufFJueO+zCuN1s0Mrsn9BlnW8WnTiMy/UipgJGhq1XWp8iYF4UAKmrf
   jF2UmrdiKVdhgivBo3c/SFKHDzbNxXzDYibWycBT+37bKqnOy8lHEFWq7
   qheNeGin4GyNiEhP00FeShUGCzqcBmfe0yJcRVmTgojST5QSBZwSHohY2
   VkJk6bRvjf6Dd+6UxbZZQYKw2dfsOspXl+cmMbU9IC0dQHknXbLbokjUs
   vVLN87ZQM9Sh2rYeeNVihZTQs3dd7wlwBSnvL/ma8oWXyXpK0M1g/7mTB
   g==;
IronPort-SDR: nWrYT7ENlAd2tVeFTloov2WHhcgQaz6bRilunG4VM7kghgDXkiTB16by/zQkaKTV1HeRITFgs7
 nnK7Ziu9WizxC2jA4QlQXCiw9hmfzg1VD+3PKYGWof6P/NGXpsqQI1ZDNfeotZq5gGnOrZAIEE
 vsftgKF5YkJfUvoMtEWLMAI+wS5/6tNr3iKliDobOcVx0RynagPmeQOGPU20/JjO52AoTpLcLc
 Afii6dnL7divLY8iEIiuMMZjKvpTPb61fqWkyVtrQWX8d+CySdGHsxooIs+H0rzXVVWC2t8Fi2
 5io=
X-IronPort-AV: E=Sophos;i="5.72,358,1580745600"; 
   d="scan'208";a="136314214"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 19:17:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6j8Tf4Zha0v6oKK6c8nIfcbBLSm2oJcKu7cYRHe5mTKUJGqxSr3oSbu2DQhuelFk61zD1lhIWrYkX3D0Z/7dt6LaVJKVRajw/WHAarr6smApZw5gQfoFibJr4kJ4BBdXaKOZaHAHbair96De4JWNMg2Fjy2fpApdanNNRgPuJ1aF/150Mz8xDxeLXJhmt5WDaxYms4TEQnlWZPmHtw+GIs2lik5wuceYxatnJSCpzQjHZgELGVYMjKijmo0qV9OqjoKm6ae3SK1cZVTpfKhPx8HT9wo99bJMaqB1NDk4O+LGwFlZQ7gLaMjD2h0KaP1+h2nYjeTAKN3G6RfkFZ6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4PUGOHEQgslMahW8Jvvov5B2kJunwSEi8w9b2jhXoI=;
 b=ZE5rU6SrnEgWVn6EwHXsqQq3M5nT3/aef5IRb5zYoxEy5o44bzSOoOJQDGj1qwoBnhLpamzRyDJcvjmhKvVMg4lclrxCO4ofusiJBJzV3+uH7iuns3rGYlac0rohEPbSGd5GlW8vkdEE68zGAGj+1NTakJ51wUD2MqYj8LbY8GW0EbEBE6+F0AzfD7v5KFhWDr14U7xw1jarpxZuQAdYy1u+rQK7wC097o5xipPcwPAFSjtKqCJs/r3NJLFVRe7k/zhjH3bPISXdXq0h/B191bSgq6xXPB5uxQwKV0jlHiyTAQ3hX5EKCeNROtQFfAjoJgya3GoF1bBltstv7LDRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4PUGOHEQgslMahW8Jvvov5B2kJunwSEi8w9b2jhXoI=;
 b=kxjhnJQwcESre3A9OalZXjyaypq+p8rIVV3PFgSkPpZD19wuHCNumObs+ULMA9raKRzfjUhN4JvMZzdbey0A3i5ECIbBOj11zCYGlAk4cWXSgYog3+1n8m9WgZZJROfVOVMikGMnUoh1+VDPfMi/dRJE0hzczScJ9EwfNzgwLxY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 11:17:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 11:17:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Wed, 8 Apr 2020 11:17:21 +0000
Message-ID: <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fdce155-afd3-4aa4-9f99-08d7dbae6831
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB363008B578B97DBDCDA84A189BC00@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(86362001)(8936002)(110136005)(966005)(66556008)(81156014)(4326008)(64756008)(8676002)(66946007)(26005)(316002)(66476007)(76116006)(91956017)(7696005)(66446008)(33656002)(478600001)(186003)(2906002)(81166007)(71200400001)(6506007)(53546011)(9686003)(55016002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jv7ksyAV5wzGPyDdto9bsrQ5OKwstLZ2cQYdGbgyc4ULOKhFYppnwZOWnCkKOnLq7fEmfkTwcXszCQRUtiZKY+TLa2r9Ntvkoujx+cq8W9aVo9kY6J/If5W7Ajwdyd9xzTSWeIsWZJVul5zUZYndZTtdyrAnkcigAUj0kD8VygWE50ks8+m/9Hv2OICU2YUYF9QLzTxUE+Ix9lUImd2lX1N2IVcME3F2Z9K0XLSQYyKDpeYeCjKZyqUV3rfHIrIVcqQHl5EdP7pZFouuxNECtquHCeNfzfygE/lWjX6EL+JslJ2yxRPxoJXZ9b1EMvXrxAjNxzYCtz7u3cr9jr00xJHAGGfw7GfcbUAg6thYy1TDKje3+DJkg2ibkUapY2BTAB3pPHSy1Z1K+nQtd3t+4us4Kd9muPP5d9tK5OG2upyTB6HwaemL8Pi+aGyx3I7UCKrNvpWlqxH706zHro1nAptP02wfJrjmzp9T+0T0sPFnYxzc+nlx3l6l67NjuPnBL0ZudHU9CTE2bfdp8irhg==
x-ms-exchange-antispam-messagedata: mGQ9aIfpRSLqolh+RUpIiZuMUPmyiKQfDZQXZHFJ7M5QPCNdvVL7Kz/5udenb6XHu+0hh+Is1+ZbwbGI/ekemyH+ebUgO75QNkTTMwFfSs5nV51bHdCan5h6afCYpn496vPHkgksB5f54HC4N+8Qdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdce155-afd3-4aa4-9f99-08d7dbae6831
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 11:17:21.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MXgP5L7W/D4dSL9ucimdF47/KwnsZgwJZN3xUUcWr/EJ0r9tNhA5o9r5DVbSJzZE93cClXyqhYA4FvGew2WPIpjs66LEnr7XSYABUvkufs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/04/2020 20:02, Chris Murphy wrote:=0A=
> Hi,=0A=
> =0A=
> What's the status of this work?=0A=
> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@sus=
e.de/=0A=
=0A=
It's done but no-one was interested in it and as I haven't received any =0A=
answers from Dave if he's going to merge it, I did not bring it to =0A=
attention again. After all it was for a specific use-case SUSE has/had =0A=
and I left the company.=0A=
=0A=
> Also I'm curious if it could use blake2b as an option? It's a bit=0A=
> faster I guess.=0A=
=0A=
Probably yes, I haven't researched if blake2b can be used in a HMAC =0A=
context, but from what I can see there should be no problem. SHA-256 was =
=0A=
chooses because SUSE Product Management needed SHA for their use-case.=0A=
=0A=
If there is still interest in this work I can re-base my branches [1][2] =
=0A=
and add blake2b as well, this /should/ be trivially done.=0A=
=0A=
[1] =0A=
https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=3Dbtrf=
s-integrity=0A=
[2] https://github.com/morbidrsa/btrfs-progs/tree/mkfs-hmac=0A=
=0A=
I just don't want to spend time on it again when it's not going to be =0A=
merged in the end (for what ever reason).=0A=
=0A=
Byte,=0A=
	Johannes=0A=
