Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6410205567
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbgFWPDP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 11:03:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34529 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbgFWPDO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592924593; x=1624460593;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=agT0/O9undsmZFv5ndte4E6MEa8ZD9I74IeTB5TKhvU=;
  b=F7kZ17e+PVEok+OL6YZ/juRn/ycs5cvtfJF/x0Ei02ZkrKBe55uDxlKR
   1poKwGbuNDsgk4fFXlixPuSBilNFzLI2JMYvebd/O+huwWlCW1ZRQcV9b
   sZfbxpK3wNrkjBAFhW/rJasJ/vxF8E2RqKTbok5rSJatcBZkPcO5ehn+f
   qEs3DU+V0a+SzjCzxVXHDz2BOoOkR9AgROBQ8qZoK+gwbImwgGODavUy3
   O/B+Cvhe8x1UNnVjw+/f/Wb/cGQ4DvhXvoOqRvH/ZhaOa2AyB5sZEol5Q
   LadhRRkKG8ASQhOnUG5rJeU1RLeN1vBlGGwmsMzxuG8airGBksf7fANLY
   w==;
IronPort-SDR: VodNdKz/vaioq/EvQM+0AWRDDqw598KL4tkmO6EeHNZ8xQSe5B3xBtLPTJ5IS9sJtjU0oJKFxT
 fveLvqHvHqPDuWMHZV2U/TND0r7BGBTf1dFvm4nLF7smpHbRbyt8VZyrUwpHgZerfbQZprcKb3
 EMQpXNXDp1E583XdPNNXAUbLo+UH2Ay+X4cGdjySlClNTjf/bvSmzN3shM7AE0OICFb8mrtNeb
 Y28a/TcBZJ2x1/s9fn24KWuGAWQAQjWUBoOaZ93t88MyOO9idZifI42ZmTaLEtdVDiJHlCGcTi
 VhU=
X-IronPort-AV: E=Sophos;i="5.75,271,1589212800"; 
   d="scan'208";a="249914859"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 23:03:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM1V4er7Jg03DBBtTyBMP5/uf9LH3jFj2y3XinKEFRW3+FuznMU4oQwx79eaJKamfjW70pT0Z2Go2LiEJzUx1i7QunrNBIGkYOLLngR4KuFy6rcGjK6IiwuiFEsorK9VMIb2gd8QVuEgkV9ZGlS4z0Tzp1XW1exLseOizZQuR0pJHus0snt5AlgHh8xLziKkjqZnY9Z2he+dsE5o+fLmaeiP/nm55XI1dCEkohm/UcZDB0pE+3VxwPIsAPcKit9ASP//YheSneVVCKfDV0tJAcZ2stfKHyQ5iviBPXCebI0bt55rmKE6rjY4q4YvihTNDr1Z2a9RycGUq64s0twB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oibfJepdnlRfmEdNlTkfXGivnIvlhDqpE0ojZNInPX0=;
 b=ZZP0lHbV3osYc/yqxXXbZ/lRJGmW5nh1/CREzbI91nAJ5/P8l6buL4EY5mAl/BR8VA8Pv2dY29YWNnzrw8oHHF3wcZkHR/bPnV2m4mzBsoM3eW4J9FD/U3F927d4+2wisFpxGtFa3Io5J2KwR+FS9fSm7/73oimzcEkjao3P1uq6LSSHxUSEa3fR1/671a7mDR4dViH7mZg78ECnRgDEMpP4rk26Gis7UO/EozLp3k5rEfRYy9TngsJWEvCn3c1vUSsuMhNEoGevdMBvFFRyBGd3tWsWPRR2BZS19CS/QQKTxBPKcyaW3V77czmlAI8lJR3amlflUHY0LsJ45C1UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oibfJepdnlRfmEdNlTkfXGivnIvlhDqpE0ojZNInPX0=;
 b=eEEAHKxSaCpEQ0PrY9UjMY8eufyq4RwkyKLXu6WGF+pDgNRzcQ9h90hLV57aF7FUVoCfTibIp7bbmhgBGu9rdJeA9luMJXf/q+7SlZjbh8HkQyR/IP+/ylpeUfOVZq0u4OEWdURJlC5fH9o8iFu5wVChab/ywAxZ26wmb8lO4m4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 15:03:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 15:03:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Topic: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Index: AQHWSR4lPNaufSY3WEGLlNOGkfJjrQ==
Date:   Tue, 23 Jun 2020 15:03:11 +0000
Message-ID: <SN4PR0401MB3598CC48A53558D70DCB3DFC9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200623052112.198682-1-wqu@suse.com>
 <20200623052112.198682-4-wqu@suse.com>
 <ed6eedb1-26e9-c209-900f-069322a02503@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd8d94dd-2f55-4b37-705b-08d817868bde
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB36799B721CC6619F0389687B9B940@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqzduHWaSoGq50/iFc0FRmB/9WUJA+CM/1QTU3hIX7E6ro2VF7t7WUn63prLBfHkz5/mGLyPOHg8sknQEeAFfNiIRxCymapI4taGMziXuCbvVLEaBhVp9wjXazTUNNEbyJP3Ic2/vmsz5vXFUw84c/9Y2YzSTyeFznA4TdzH6epGu23oHFZ/fzh8MSzQJA4xks6aPISNg0TUsgqWS+6LYX2x65XG5A4uAt73Qa31hpTLcg32vRlrEVDRfN5xjB7oDOZecMIQEuuj75p00FFh4u6//d6d2e6+W21Y8b0jvAOFc4ypvvNX1vhwrNqh44vOelBEUv+ajCM7X1roXiwABg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(9686003)(52536014)(8936002)(4744005)(26005)(5660300002)(55016002)(91956017)(8676002)(2906002)(86362001)(76116006)(66946007)(66556008)(186003)(66476007)(71200400001)(66446008)(64756008)(53546011)(6506007)(83380400001)(498600001)(7696005)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tbnPSIE3fXxYmRKh882npZZ0i35AH7dFhZIMucWwtfi2sZ4Vv6IXC3Q4fMoPrB8m1Oo58byAY7BaH65i89/NtkhByLDA69Haa9SuR1SHaPeKyAmFF8LYGJPoEqjawuilYTv7uGnPyM+uN+sE9PEakrAIqs79l5cso0CSV3U2rANTIIoanDRXhs3AZ5wiWubrlg9WWcYuXkRdzLMoXJZu96nV4j+7XlzDgZgPYtkf2ppv81+ycPUQwO0VDlI9R5KnNNGYYY9BCurnaSlkszvMGvr9ZVsNMEWCcLlT/1KXpUViR+G+GbgKzws6sFS8XqUagjLGpyhLPVznbOSRnePFfoLyZDL768omktrR+Ucl9F82u3VwV9ePh2qc0sRJ/fHJYk043/6HFhtoesOXCAig4jdOt7Fb1OiBgReqpK6Zl/uywLnl6Ok0qrNh84gHGtEr2rR2kaoAFD4E/XMXpTSGKUoJD/RG0kZpIk+G35ItTusRcLfpmS1yJwo8c5XYCYvR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d94dd-2f55-4b37-705b-08d817868bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 15:03:11.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLWKFncjjf1KFr+AVvcp1/XysxKRILMDN5+ORZb5ZhzZkrtvPAVLncl/gfcrbLDM9KByetgQVJElKTMW/xc3IwXBwEcqs+OnIlo/E9eV7kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/06/2020 16:58, Anand Jain wrote:=0A=
> =0A=
> =0A=
> =0A=
>> +static int check_nocow_nolock(struct btrfs_inode *inode, loff_t pos,=0A=
>> +			      size_t *write_bytes)=0A=
>> +{=0A=
>> +	return check_can_nocow(inode, pos, write_bytes, false);=0A=
>> +}=0A=
> =0A=
> =0A=
>> +int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,=0A=
>> +			   size_t *write_bytes)=0A=
>> +{=0A=
>> +	return check_can_nocow(inode, pos, write_bytes, false);=0A=
>> +}=0A=
> =0A=
> =0A=
>   Both functions are same.  Something obviously not ok.=0A=
=0A=
Oh right, how could I have missed that. The _lock will need 'true' =0A=
for the 3rd parameter.=0A=
