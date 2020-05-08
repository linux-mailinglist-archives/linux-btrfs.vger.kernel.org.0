Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E7D1CB17A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHONG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:13:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53680 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHONF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947184; x=1620483184;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bIJ1qLA2hops8BZ7CGlHbRT8KopDE9vFHr8vHdXXkf3C1FW7spjukPAr
   rWMf1Pb3PtHPmlsAbgYHs/bJ7HMZKMoJP1K9fOAtnswzrb+5iGXI/lDCx
   xvJUxj+A8fxxxr/JHvA7tE0ois7dfzHCWHFL5mewHoCM0t0uTzZPNVpPZ
   1NlnnqFaNnb6xQSRmxsSAZB1GAjW9mYBnKe9HG17H099IG9vjB5KNohvr
   vJS9UZQcJG93g5/7psqjvQvuGKl2z9IYsRQsD3cTf2JWwdI1VKnQIeCoD
   YP72jfq/9ZsSHBu/XV6c6iEHS8hL+obevv77kdgy0Vuxh9fw1mhoPMpWk
   A==;
IronPort-SDR: +eP1qB7XLhh4cRssOn3Pa92TGVeB7jxJPirz0404hENPzJdzaIwI9s8MLtdhAvlmEt8k74c7Fv
 oBWjiZc2WGGR0mP3x1HhKwtKftJfxxKLF5WJxA4EHTOde7WHeXaM3H7+i+R0f9gXK+ZNB8ygLC
 7pvFip6unWfJb8HCPuLHISF6S0cy6LuY8Htg36IocRSyiSkG3Zu1DdNmEvl5ey4zoPVzLN1t0G
 OFGBFE16/UlDhNU3CdRjXv959sRv/F2ZeEfSlAZbB63c59CPygUUmQDOgjDMQIvXWE00/nM85m
 R9Q=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="137234408"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:13:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqXlWqk2BsyOM7NgqsMRCm53uCEwqDaTd2sSIlbFA2Wv7WFt0yq7F6AAIi0dhixb4j5Ywkjf5vooPkUUWW4UAMO4LYEsNmDOZS5F3qLlYlP9ChHkyQXvfFE2xs+s47Dy6+vCpNYh3DE0qKKhaHITpJAvZWWSgjXAin3GSmAqnQRexCGD3Kv0LNnW1RGJ5OzJxjkSu91ymL+jjlGFqjBNCbqeYWHrLhyx64DN1rZl3I+fD75qMWKzHDfCDt1JoVKXshcWzlPVAuzGpBHxE99FFtxciPB7NS2RF8HVhxIUSk/CAs0kK0/Gn5SPNHD717tVVpMV0xdwuWgWVELuFJqNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iDdhN0wyO5PQ6bGUFoNVM41QIvir56bt/iiVfpmeSkvSLCQ283kDIA9NfNtPLZEUNuW0seHII/5Q+exWIX4VSxnPkquNg6vOYDMMu3tMRqQ4DC7CKXsLAZA9m2PcYCi/HuwSWtlPEM2mfF0u9gTPj9eFIRBET8QTO4GD4Pctt6Ogmkvm1hVkh2tDPJq5m0CvPg+FwTw672xkCw6wsTSeSMHM188IgPHc60MHRHt5uztVjlfKIAk7ho6eu0puaP5GADKVVADTZYpxx4csSDtqgzdzr2ANxY//KPq0St4ZTEuSkE01OuUzRxvQ+XuvN/s/OWsTVa6/m+GKngUMujP6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L6N/Cj7XpLSiI94FnOGX+7iLQ7YvZdzbToktOWVXMyOP8CRByjP5h/xXPbWtwMD94gZvC6kS8jo8qky0qDgPLvqxSTkojm2D1wJmj0+WbuiWSFcvkduwEbspF8U6HhEztkS0wyMJ8/EiW/aZTYzqKNWLilYiJJIA9RVPN0APqD4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3517.namprd04.prod.outlook.com
 (2603:10b6:803:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 8 May
 2020 14:13:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:13:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/19] btrfs: drop unnecessary offset_in_page in extent
 buffer helpers
Thread-Topic: [PATCH 14/19] btrfs: drop unnecessary offset_in_page in extent
 buffer helpers
Thread-Index: AQHWJK0Ij6wwyXcxrkur/NOKyU4QCw==
Date:   Fri, 8 May 2020 14:13:02 +0000
Message-ID: <SN4PR0401MB3598C1321AE6939279D16A219BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <1adbed2929f7a9d390e62cca943c78ebe4b4e9fe.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d6331a5-67e4-44d7-17f7-08d7f359eb54
x-ms-traffictypediagnostic: SN4PR0401MB3517:
x-microsoft-antispam-prvs: <SN4PR0401MB3517BB03F52ADD6AD37CB9489BA20@SN4PR0401MB3517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ES3fnib0h5Zpq7jdFQhDMC3LQJEbyG5qvVkH/3p5TZasbDhe4SE0pD/LGjTn5AQxdwRLhYz88bu81bTOZmAN8La/J350RKAjRowjVAsyzHt2kLY4Bul7T4cqlRpUlvZskK+yEETzHzBQ1qk8ZiHnkZDaWdchU2swOuh3K1dbGZQsLwmp3faXmgXBxQWkAE17nzPHaZ+Ct+eePtBKE5/fwBIJgSOIqKVveUUu2W2Qu00/97YG+ixQzl0jc6XYl7tkV2GVzngRK1pAUuagff/EqfZEX43X/qhmTfFUihNGazFm7sMociskX2jIZsJUSCiXFI3Sxc9maH9B0GqVNc1gF17VLkxdQskb77qX0q5jI46WeY4L2OKwPDqkeK+Jt0YwCB/Epsn+QGKztl4yGT6+xeaFdhpzztoNYwqFGue92oPI8p1lgoX7SOQCPbIF+aih4qg0s6rvNcQ9N8+NSWMejF7PkVryJrymhPutz2yrHzxn+D4dBdgifimmYwSvsp9ChfYlOtGr4n3AFbgQ8ViWhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(33430700001)(478600001)(86362001)(5660300002)(4270600006)(26005)(558084003)(83320400001)(83310400001)(83300400001)(83280400001)(186003)(83290400001)(8936002)(7696005)(52536014)(71200400001)(8676002)(2906002)(316002)(19618925003)(55016002)(9686003)(110136005)(76116006)(33440700001)(66556008)(66446008)(66476007)(66946007)(6506007)(64756008)(33656002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HoylioPOmW+Xz+FNKfWLA3AK9OccO7yO4YuTYkt0cD1fld1DcZEDtaBkNIBje/QpIi7/io93ddDg+/uS/vsnt1gaZ9sVf75eWHS2qZxb2MhoHSxJqJuTXMu/JwqGSi6oW6WunUDShBuquIlvFLBSrBhFdKqFEGnsnCp4KHDf6FJLOaPNVJPrkH81rkhbLdqst1ZtuMuxPTO0FidLptzmLVaSOUh85Kd/C9XLaV5crGfBwdS5USLSzGVkQ9nZOiwGQtvOrgBA7QjLr4cvQ9ZfJszMQlN2Ywn6EoE+qBI8f6PgB3ArdRel9XxgOHoiH9GvPkVKwAGoBIb1bNDrWDyKAFSKctdfohZf52IxuBittkJ91CsTMKJg+KghpQdQ/4cZvDImGNWVbEF3/uSvXoCTeLCxxP0GWmJpcwN16ZzSYTVBc6BUYUy8FoqTPOXg/qJRmw9+7IrIXxkgP7xf1ze+jJ8UIZ+Evszrgnu3JikB4C6n/b8+CwWAmf1Sv6XZD2Fd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6331a5-67e4-44d7-17f7-08d7f359eb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:13:02.0381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FV0SR68LSje6RxOm1Hfr9DzYXtHiMLW3pOs7ajYB2p3qs57sMEetgNui1JFpsZ+63KiGhM0KKAmKnkLt+nE2oTYLsB/Yk1Iv2uTrUZWCgdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3517
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
