Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7948625A997
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBKj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 06:39:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8768 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBKju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 06:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599043189; x=1630579189;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QbsG3IvrlQseJYSuABmG9IW+zIvM30Imcxovc9GvMMV04AZTQMWSp2Rr
   rQxYImi9TkQtzq3wUYioWBUjFXazhuPnJJ/Ds5oWr0s3Ar2PIqMzpxstV
   1Bg/t2yZOM2ULTzxhGs/GHhwdv64qvfJwV7j9zWJnxd+EAQLJq9kR3tw3
   wAKPmPifyJH127lMevqRtTEUrn1jiR7UJqhk8ndS1BsNLaeauDemMqaWr
   QfzTY79KHuVZYfZkk5EfrWr4VeRYGCYwLh+xajvE0aaHodVRg6MQDU6uJ
   tw2KC5ZeEMJTAN+cNkpo0yDg1ynm8+s6ALibIPJo8PFj63kdKZEMCN9qs
   Q==;
IronPort-SDR: HIfC4iuWY3WYQf4BzPe/34EFRvSa0L34pXAq97A5sKA4S6LrTvK6xhdfAEmfQvai8DhHLTjDzU
 61rx9EgOLsi0ivumECaT1a7EMCaurKNjlUqQuGMWTtcVdGsuakP27QhuRb5GXqLQfw2uSaJLGk
 aXKylnivvL4y93jE3r9MSRF1RQB7shc6cOEksoitcU8eO4mYCA6wbsdnMvVMz+avwDlC4Dcb8J
 yqjqDmrAlcsU/oBaK2pD/vENKkdKGJTfJiIlGVMJjCrGo2CUhzc0Lww0n7E6rWAVSBEFvUAMmh
 I64=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="146390141"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 18:39:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AULA8oqnYGk+jhQJWBE6zfcOmie0NjVIYE1YrGFRX1lmupnRPZErbnYyHExRokXVqSMMlp9o0rRCutuuLnGoqRN5kpxh5stj+Zvc99u2xAv6JvFH6sd9qp1pjaQH7VzfF1t0i/ORo6DwJgId7dqykZW4mZNAi3/1d2lvNUF9JgnHKetfB1F+evZ4TuFYKmvIcmNWCW7VqhxlDjVci1BykIgU51PgxZAMvbMv5b1htFSJFtt1itUF0aMVMBkJa/gFc5l7SaWxXLH7WU/sps1T7DQaCFQmkTiSRHvQObpouYfPsmDbD+xM3n+FxDtut7GcKtQazxyzqD88mnFIpZh5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Sl6rvu06ysdUPfZnuZOVD5v4S2+d/4cM9FuJ9Tj4/Nxg1WBMBg/BuwDLKb3fxlTz7kLHsnxqKQvHJtxag4Ru4pbL8jBpO1WkDpqtcZL16NuFLNccjByAbo1o2tYRE3vSB7+zRi05OmIwC2mIycURYwVPMIFDnPZQAWglbULTOtutAter+mGdksIQyDPRQdHwI5SvBP2v8pZs022NpBc+PGw5LX0XbiSI2Z5TRNKsZ6QypBdKxBd0w4qlXVb8VjzcrqD9FQOl4yYWSKms4tPZa6DYPXI+0avS+Cnfma6sYPsZYBwIcAaXX1z08vDABBoruOyJWWRV3eAI32WcP+jr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=r6ELuOINHZfb81REMzw4oI6NuqauqeKol1SA/VTyEec7dARJNtaJCRWhXHxKy8TBDiDH8n44f2HhiKpXxUaQsI6ftmho4FsdXg1rmfeL9mwbwTpq1vhcMGClk6taVPq/jFKaYg1GRStO/K6Y2Fas9Or4x0+Sd8S2h63k/qaZm5Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 10:39:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 10:39:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] Improve setup_items_for_insert
Thread-Topic: [PATCH 0/5] Improve setup_items_for_insert
Thread-Index: AQHWgG33M8PQX7t8wk6HTJNn2ZkNzg==
Date:   Wed, 2 Sep 2020 10:39:39 +0000
Message-ID: <SN4PR0401MB3598760D6A6D511A0353822D9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901144001.4265-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8937d79-7f91-460b-7d1b-08d84f2c7e91
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB3520532384ED199F8F30F29E9B2F0@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+0kY/VCw+K8rJf4zgMDrJbdes4Bi8bM9HketwFOL15O8XYw7ON0oOmgpiSc81Ii/A/G6ajZhqxNbRbV97cx6WlzbfHng2KhrI5n4rYQ/ckKx1REYaY/aDZFD/6oqU7jmfybVWzBA5HPFYMK4uJJzsJqkC/IPqrI4thsu0LUL1W6l5D3IOVmvML6MNjg7SpwMfZg21Ihz/Usal/jx66uYYbgSn9bCHa7kMp1Oot8pt+tPkmCCDeje/ecfU5dA4lHnX5v+co0mJ9AZ3MD7x/xrjds+DTR75SCYMgtg/zHIKhUgPhbD3Zf0DN4Mg6TIDtmty/uEcGW/QJWHwrwP0CNsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(8936002)(4270600006)(55016002)(9686003)(33656002)(498600001)(558084003)(19618925003)(186003)(66556008)(71200400001)(110136005)(76116006)(64756008)(66446008)(8676002)(2906002)(91956017)(52536014)(5660300002)(7696005)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AembSUJEXuCh1aJq/+aln8d+phobpVsKcr9Ly3b9swVcB3ALzHjXDABvKX6y46EM7dPkGsFUGGCLrgc7Wyzt3MSkoG1Xmz8jgwcqX7b5It0MRk3hOj90dzzBHrxhHPU0SaXTuRgeSHT4dAfyjkMfHIWZ1EQ957s6OA0jytwMqSUSuklwWr0q9wGI5tpdNKUJriCQZEK57ePecCYMdzN6V42Pc0IipKZURDAcTFYs4EgppowC1mBJ09HPaCCLwoxyRrsOm9ZNTTaimQNBkpdFJb2/+zOc8O4ZGLdJqREG7YNUwAeuUg8eQpjL1DvzXdGRi8tq79iW1mPjV1wvvLeX3CECOOclmhtQbGcDOIOGaURKEr0SujWXqyCN3OQxXdX52tE2+pVq7tGjJ6LD55vTU5nBuMBS1VWkOVCCB8jPBkqFktzCWk4EHIAqIXlUVrGKo33X472t8+kKxtbLacue8ubje7skNC/qFZxOVUIJiAujrdjLncQ+le871iS6G6h6CcMLWeIkTi+Y7atSJjNi1u31jvC1CD7lMuYsAs8BDktHKUmay7nhyljyU2ndvIa7JQbSjVzIvHwwSHLwWzlBQZMZB/XpfVarZ+utpS5mkRtUn3xZD8CBFMswz0XBOodkiUEBGz608cMs7onej57gemcSBrtejzG9uK6F3FpSMRNl7QzZ5WICcTjBRytfFzYb3HBs7Tq0udnFykWhWnXOIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8937d79-7f91-460b-7d1b-08d84f2c7e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 10:39:39.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09RLUsORp13fWER/UgCTrp3qjSKRdlYycVAk8jhlNhRdzjGUgWHnhd2Q2oQKakmYX8LOg1D4LDoP26Mb2UhEXXGPM5vBL83DfBvkjNtG/BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
