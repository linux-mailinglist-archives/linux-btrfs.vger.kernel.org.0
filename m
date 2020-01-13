Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110A61397A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMR1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 12:27:04 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62516 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMR1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 12:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578936424; x=1610472424;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=xmXoqRFWhQ2AqVSqVcPfIW7mASe72xWPAGN2k199Ezc=;
  b=p93qHQnD7TS4Q/iWn56ZKIWl24W2KycyAlhmHpaP7ulh8Pa3d2QzpcsQ
   HTX5gz193t8B3MTeMAdL7n8tHjtFmqMBKFusFbRtNEnDASZlVzRvcz+Ex
   7LiGjmB6h3A+g2XVyT/mhSNmLxjz1000FfdPFs7IUsgqnVxl80fxiy9eN
   KKQqsZlgu2tKYWAGMpoH8H30DN8YntO77/KKJ+NpgHnw+RbyF9P5ONWkf
   rr9nYRNuJy8cHjTa4uXM0snro2cFoTHk4MA2moO0WQmJGMlzTCGdi1v3z
   NME85WcdQU1ZX4sxhog+dNhOgDANjbwPGZDdM/WLlMsBVROTjvgm/sXoe
   w==;
IronPort-SDR: C12owRpWl/TtMYwXsa6lQ3cJFfzAcnPB8pWrrr/WJEF7r0gCkKmeK4ErUMcUT5Lt0JyXRSvmV6
 ScwVIewaCSo/3XAWtptycNVCwKKtAELO9eoRgOLUU7AsuwLkWzv4lX0HXGpt4fCi0Kit+J+rti
 xVFeSIyunTYbO/ZLRTzgsqI9f30DeeVPdq1L0/008R+PLFPCtb22J9xE12fIr0jjBimexO0K9C
 tmr9fjJR0elvzUPVMOdnuYvoI7FPNvGwJwRcKzfFF6Qv1Gy7ImbLakAms+sRaK0/R5hjCZAHbC
 eW8=
X-IronPort-AV: E=Sophos;i="5.69,429,1571673600"; 
   d="scan'208";a="128869556"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2020 01:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx4MwXQbVXngVIhxLAfR6m2QSnkWAtQisSTcut9TeSHHan1iDKujXhMLoXX77fbdm6bInrv/+7lDlw4j6h+NcRI5cHfJVmoyhZbm3cmSUWJO+H7yjN3JYkPLXNvivv8WxzkyBnxTDONctD+powj3CBcoOhTZYcODyybWqfs8zjBPm5q1AVTfj0Zmu9W8dVewZUO4d9D5qZJPZdZLxoHQgMjARi6Z20IvQB3K7agcJifss0RqFlLuzbrhSpFe1D+trDALq8w99gAxKNLcts+gYq06AwxNENk/mScNtNE+9fYmdWfq/4UHpjTX7kTFgaMNbyUGefI1LcZRJ4VEOmyHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmXoqRFWhQ2AqVSqVcPfIW7mASe72xWPAGN2k199Ezc=;
 b=lu2st+43XtuZzN3cl3d//IOYwbcqwJvsj/WXgd1TR4Ck8HlQEnQBhckFyoeoANzHutPGkDX4uEDV4POLeQzc1M4KHJcTLiL2lF7B4NPsmkiCFZbWmDHppVwxbfsmCGE0SMR9aMA2Omk6kicu8LZhk6hEauJYOZDc7CKBEI7UrhJiqXzRmqxl0K+gJS7ptW75zhuXjxqKJwY4HY28Km3rZ0x0RFzQzX6pyYgVfW0ua1AkRzopME21smRBmN1rUJvs4pc8nJJTohPoY4Ytec0bkCBLxoX2K3WKfcf5snLcfECAXtlBsKPnnaWNu6KZy/ohAqt2EV75GJaq1SjkMtF/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmXoqRFWhQ2AqVSqVcPfIW7mASe72xWPAGN2k199Ezc=;
 b=n3RIfNywlsI2MbzDOyUNipg0xWeBOqqzMQotGl/pmPmNcVLCrVSwMpGImBDyxO8JnWRkNIAzp1f8wtF6VO2R+dMg/pG1tDnH1YMEjGNO+HtAX1d6EhgURo/Hd8tOxp4zl2lgF0Np5tn3/5LCBqzLSzoOiYiXMpNuO6mp5DQnF5Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Mon, 13 Jan 2020 17:27:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::7d4c:6c4:d83d:fcf9]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::7d4c:6c4:d83d:fcf9%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 17:27:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "dsterba@suse.de" <dsterba@suse.de>
Subject: Re: [PATCH] btrfs: Fix UAF during concurrent mount and device scan
Thread-Topic: [PATCH] btrfs: Fix UAF during concurrent mount and device scan
Thread-Index: AQHVyjPGRZioTdVrmE+PP9lOqvrQT6fo6awA
Date:   Mon, 13 Jan 2020 17:27:01 +0000
Message-ID: <FAD7B0E5-6F36-4763-8CBD-92C9FA1CF358@wdc.com>
References: <20200109110210.30671-1-nborisov@suse.com>
 <20200109144443.GO3929@twin.jikos.cz> <20200113170601.GY3929@twin.jikos.cz>
In-Reply-To: <20200113170601.GY3929@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cfe0f1e-a187-40bb-2a65-08d7984dcd18
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3646EAA08386AAC05BCDEC489B350@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(2906002)(86362001)(6486002)(316002)(558084003)(6512007)(110136005)(71200400001)(64756008)(66556008)(91956017)(76116006)(36756003)(478600001)(66446008)(8676002)(8936002)(81156014)(66476007)(66946007)(81166006)(33656002)(186003)(2616005)(26005)(6506007)(53546011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSqJXqh0XfLiBVjQ9C1VPpWTT2OnvMefFHmy0dSZ5ew/WWibc8P+E/C0HZ3BlLVe726oJjmKSm5coouVxiKnjIq4eqn+IoGmKOH0wCPTiBXpFF5UXdR+FLjsUOo0bEvPEkUUwEh3Q4tcJTbIOHsc521FDtmNdryP/GCLuxtHlEmYlQyvLgzsaYwpiENpEgB/+iXt2Hv0KwB2KQuIaJtawCiMqZDZlMbmN7gHbS0GMXhDAtlGPMm6xhVl1V3eWSCxkRCmY0s1ant2/6LX+TUnPKYjW3G1IFManQX6mUA00pXSzj1EvTOHeDhJ7bNnvziVLyhtd5UkwfdbbW+tt46H91AJFETJ+HgTiNVJ2V2CYp7mWsZpZ3yQXEW5+A3wyLd4WHxiqSjGH5x4LYwN4e6uChhqN3UwjGRWbGPkbzZRQdufTiPVMxS24nDeDDV426HJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD1E9FF2D5A9A478BB756CBC10D8D63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfe0f1e-a187-40bb-2a65-08d7984dcd18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 17:27:01.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecZL5RYyUvTfOfoOH3sBtoZOqS5Ke9QUliP7/qQfz+tOU81su0doa3KwR5Y4xTGKQi3E1Hb76o1EyvpCz6GnoJqxcAxEUKEaEpob0NRG+4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMvMDEvMjAyMCwgMTg6MDYsICJsaW51eC1idHJmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIERhdmlkIFN0ZXJiYSIgPGxpbnV4LWJ0cmZzLW93bmVyQHZnZXIua2VybmVs
Lm9yZyBvbiBiZWhhbGYgb2YgZHN0ZXJiYUBzdXNlLmN6PiB3cm90ZToNCg0KWy4uLl0NCiAgICAN
CiAgICBOb3cgZm9sZGVkIHRvICJidHJmczogcmVzZXQgZGV2aWNlIGJhY2sgdG8gYWxsb2NhdGlv
biBzdGF0ZSB3aGVuDQogICAgcmVtb3ZpbmciIGFuZCBwdXNoZWQuDQogICAgDQpUaGFua3MgdG8g
eW91IGJvdGgNCg0K
