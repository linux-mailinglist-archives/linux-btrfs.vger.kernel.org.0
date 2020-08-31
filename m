Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E05257A4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaNYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:24:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45780 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaNYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598880252; x=1630416252;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rqCBb5TntiLPy9Q+KiCo3lFLuI9Hi9knjY+lGsOjlXMv+stege3QmGNl
   mFOcZ6+ZpQOfoZ7SyuByD3ynKIzg+AlT0P1ZnOkhQIQse1fKGJcxhxyWU
   mfD6XEwWspus451oODjCz91nwCD/Ga7qHqp+OtWrcaR846hoGq6YaxBJw
   lWR9nw4O1+R6YNHoQAYRfj8GYJyewpOMlXYLDubX3nmIRzDsy25+CVx4R
   MHQzIuGLqJWQSszFfDsx8U/vOBgKHRh70FglzdTMZBW7SuU2cbtdofzyi
   hkE+3xekK9Fdy+i+pmSPMp27k2uqhRCjf+yXMkV49Hh82Pu+i7/sFFymV
   w==;
IronPort-SDR: bIvfV0JnPfrjj33MNFB36J9kKeFhYFk4zGShro55FEsWvzqt+zacbmoGT1ij/LBR/dxP/lIFS/
 ipZfOg+T+DscfVbgbXR/PPg4yBgLnLBNu26+MOFHVVzDh4wndCJtLTCkSk2EMLl7bjw5ULL6D6
 0pKTZT5ZeXpPi7xfy8QGj/igz3sSBZKLbQ/8b0SSBN026+QFSC2CfOzayRW9eJEFE54/YBo681
 rOWd1kDoE1WyMOkzwY97SJU44JPpprw61pxJrrnytHHFzZ9jP/hI6t+AA0Dasr2aX+6RDiFU7I
 ins=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="150562664"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 21:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgA9F3y96fF0wkgCGeFOytHxT1irTKYhz+wbQxIxdoRmpGcTkVPmVkgafkgrqOepKDipRFUSLDDiccSRobBFbxUMOPdSEVK5q1VvrX4lrKKoaByeriPNIdOq0Pk98pYH6p9PhbwHSk0VE35MizWnNmCQ9636XDxcFLjhWRM9OcVD2TicVyru2BR6WYxpKbdNUonekVe9ASEuhKVAEbnZhVYDU/k0iqM0d6oqAC6SJRPRNlSWQKuB7NX24F2Srr75J3X0NTJK/Z1bBJtl83aKZDlFaOKT+kWSVj/TN2onmzgrgxSPQu7lvATBnYig/G/RPlCVWmaIQVThWtt+tVl2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Cle8zLH5tsirXM7Q8uvodqfSZivzOIZxL5uwrrWNxxhAGqIfnNz3SlV/fe3Q7XuhdwzifzYSvbt6gYs7PCLrH9VQESSdPVzKdNJ6ChGvotiC+tn/kf1TUCCIwiIV8B2RrePx73UUvrgjt3+MtgQnrXL4VIZD8lUaR0faw8u5vfnFG7s7AQOpbrCAvhebZYHXC4Bl9h6vSL//BW25rkNvIEbjHHf8NJaeHFVwmM3G+mDKVBTCVI8lIME9gZBriGGfl/lODMc1/g9Tsyy34FtFTLMN/dezRpGK06YMfUbGC0pnqSndBiEUvYjn11wvdMt3ItsA/cF2yR9oVEK/Mur7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AMWhQvJ5Gdqb1Sd0HEHtgHdF6Hl8U/ateNUmvWHZPvFTkrZqHormp8eVYb2uzBt2ClOwGFSnCBGE8t1VDsyYkjXTiIWyqOQ4Z7O9FyjFeq6DxJ1TAvsg5pQq0mQW1m664ZzfjIZTqDrLtc/UDL/pj+gXjdwUFj0BQ6XR4LcWp24=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 13:24:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 13:24:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: Make btrfs_invalidatepage work on
 btrfs_inode
Thread-Topic: [PATCH 06/12] btrfs: Make btrfs_invalidatepage work on
 btrfs_inode
Thread-Index: AQHWf41q/O6W7/f7hUmsey2DomX4ng==
Date:   Mon, 31 Aug 2020 13:24:04 +0000
Message-ID: <SN4PR0401MB359855265D188BCEEB8B34499B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-7-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6bfdd1a-4ef8-4b85-212c-08d84db12211
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117A4CDE349F0FBC034C1AE9B510@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UwPUidYNTZxZ0ERZaFnGrK73NR6he9IE/yE1xq7hmbhRYy3uI4K2wVaySNKM5Q9kzsDsJh+sq6HQhzLHCj4Xis3MiHYXgIQTJdxUpoZHGNLZnGJ28eFKe9C3JvWV4xhl8B/B/vgTtCZSKyNjhvunFogk0T7HfdaBAd9zkIwfSwjJTr5Yz/MGYv0ourdB1170gQ51/4l3x7q+LF6zfDuaOQBYmMetTGIIVgCuQ3Y5/qXokrAEForXTJnp/GaTzy2B0QFVuvVQdNA0yGsOIl2rFmmcQVtTJmFVmj2TfxNIqA2c3HGziD9e8S8WLGQ2gxXGQN1wO3c05e25+Okuovf1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(66476007)(86362001)(64756008)(4270600006)(6506007)(71200400001)(8936002)(5660300002)(52536014)(91956017)(478600001)(66446008)(76116006)(186003)(8676002)(66946007)(55016002)(558084003)(66556008)(2906002)(7696005)(33656002)(316002)(19618925003)(9686003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f1+OfQ4wUlITTNv5hea6Faoe87a9vp9/r77S64n7GiHdEV+HSfazgfRTNQArbeir3w3/ELHx/A/49vbCehVDudL+QaqD4OVxhO7lJn+lX6f8qJ9P5rHDOfjj8FNelrp/968T2dXjpteamuX0ZzTqDi7PcWVyKzu6ZBKpAShIgTv6aF62AX+/I7JMcfCzT9aWq9QrYACuZAU5gAeEzADLPht6TlGT45WxuzeBXkJN3QIq0Pbftu4cWEPwC2Df7NLwWeUZyCK3WuNM5v8LGdmzUPGA6YgI7qZoLPBGXqwKbUawlpR2d994PpBB+43ABEudW6+RuISoL1ZJZyysUKLP+kJLjhtNx0RazOQV1mkkbpCnBst6W42pmrFcpBaqCYMYRm+KDs0C7NZLr0tW5ePJF4fU4eT3fgPmpa0mm3YpEcorS5Ur2VbcCS7ApaR3gJK+8pBr7knaCRlcy2BX0tCRlhSLLrgJPnOTIBK3k3lBLWZtbfai5F4LUFowmCBQGQ6KV2OkGY0hH2IxmWUxaaZ0eKja93Qx7Jujd1KvoRe/HW94s7h5EVimtTPeczpr6lB4k565k6P8FEiFRoUbkyGcFz7NSjBT7tpi1XlnMRQ9nbk2umNNdD2Ff51nVU9UoBMT9UXDYVBqvOJJxazKOmA1Znexc1UfK5JWSwnITtExKQmRQQAEadR7ixiLmba2zY/kOUXhv76zAPodEL2xGkr51w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bfdd1a-4ef8-4b85-212c-08d84db12211
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 13:24:04.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDYQYsUH+RulECkua8LUEcZ4uDlbkC8MD7O2EKYK4JyhHDJnKpt7X/QFdbchEvnxNKrIHPeTLtqZ/5JM6BDOBgJJtlj0yytYbLEQwcWtBNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
