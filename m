Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D523C20724F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgFXLli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:41:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39375 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbgFXLlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592998897; x=1624534897;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DU9lKRGQm7iAbO6+h8x7fet0jf48yM0WWvk05HLxEjw=;
  b=oLgN2oFlHKS9iyrGM57h6DD73wUnjxj18wR+NhzcZdlrHXYrWmzTXsVs
   njYcT1nH3p1D7X7LyjnAKLFCn8PenofOiaAAFS5b1ltAFux/MYbDLAm72
   TxNJdLU2tJlJMB1410R89U89MYlZLdc38XJ0eX0yeO5Q3hzATl7PZpUyN
   8ihutqEvRGHNFCw/wV5UcBYxpRJ20hY8c/QFFZkPWvJoYL9BrV/anrAM0
   Frircq/8HV/2Qk817nL6gKya2jRUrcGmwUU5irMuzGRtjemUpoWgz06RJ
   2ennSr5zd75qapqM4aMY7aJH6TJnik13N3W5Nv9t/De6Bjt+0hlkdZ4qm
   A==;
IronPort-SDR: XwIlp6ITdG+cNVM0e1Ry7OonmhP6mQXgEKGdiAKRGhUgg4k674e7DOyrZRtRUG4miOEPxKJmZW
 2WVLR+Pv8Ci2gchH6Hg2mBrI8tUN3/FXS974DZw5s7a4KE6/lUBCrfYRCW8zC8ySwYN8ZjU51r
 2TZUlvcuz5RXM5qX57eL4rRHZ4jX4MClxxEroEDnx8ZFOSjz8BW5Jlm75cSkhj06Uy5i3XzjnU
 QdJEIPbUn1JvZwX7Ow0/EtltFJUHYGqOBLTCTkRmjUD8Q+7EZO5zsNTabiYbqOe2Sh00b89r36
 sGU=
X-IronPort-AV: E=Sophos;i="5.75,275,1589212800"; 
   d="scan'208";a="142166164"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 19:41:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLwvaykIYhDIzdeHbiFgfPiz/qtfov4uk2auR5NYNNqlIQVvucqa/K7IHHRD6ZD1zzxoK9KBdaWp2PYxIZNnJmiOF41ScADKERC89LNMgRs7rVws9MuIvzej6sfxJZk/+m78Qll68M5egEXplJI8s8kn8DVul6nB9trprUUH1VXvL+LAGegNKCF/H4DyiL0gpgrijOaPyycFEwZb+cBADZ0J1ivAiPe9in3EhIYld1eCwcpvpb7SDAiA2MaE879Z+Fcv1DHw9/PSRoc85xNlCYZ06Dn6w2zgraYt7atC2ez6t/845L+tMgFEuiCuosPMXGI6FrVDoraVPsDt8jr8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFVF45OpsgNjLFY0EU6MC0pipQ1EcXcdIpbPsHUKrrc=;
 b=Hk0HeNbz+t0rdeP8x3yZohboiPIhZiqiGkMV76khUBJKANpLdc2o6Ws4qi2Mpr38IOhGzTp4StEl/Dl0h2SW1ZllSoq0K1fj6BGeDjs62P+AVKKUTdnwFsLgdEWsgwplejlCAS3dcQHAxDjk2/BPtmybAZPr0nefHnGTIy7EhNkIqldfg5jEn9YpoM2eAa6cutpApPBpo3raW+pmA82YtgxNBUPGG99h1WW+GXZV7Gxjn7pmC4mrRWHL1u3Os9VgijlF4/uPOhFdRIlc835US4cYUuhp1666wF50UEtXf57DFBjzAGt0qY0SscnPHXxxzD0qV/BXKLgFpcEnHk8PFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFVF45OpsgNjLFY0EU6MC0pipQ1EcXcdIpbPsHUKrrc=;
 b=U2jiSJv4hfGcizyQlyOV3fHUzkaf2b9TNmgP2mO7mYJ61f8IW9qrotOIuziu1V1X/Q5u/UJUexr9suJqfYKd2ZDYWg5mtPuIJ4zpIZT6+JXq/AG6TTyiBaHWrY61Au0FfyWauyoap+hb3Vk7nikrg48zBP/CzpVuhnksrz7x1V4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 11:41:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 11:41:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWShFCK43KMhBSekKBmLU/7X0PZA==
Date:   Wed, 24 Jun 2020 11:41:35 +0000
Message-ID: <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab47a435-f280-4edc-783c-08d818338c7d
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB3520CCA42122E67905C07EEF9B950@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9mEbT45E8Js0FPC2W/RCfLAlWA+lDmyAHkYylIpn4TRZS/lq/I4NrOYITmXRVSYZJM9Ua141gNwAkeGPYIKSVmExQEOcdR082H6iB+I36UsKhGsGnBYloghEX4CW9866EXtPkJ/5Oisn8uug2Hbresi9Gm8qfsC0eXrZJHBC9vAxKTEi6N1xZalFyKnaOeun+bk1HF+Xb64T1d4fmeQaYIp95CcihB6/CqcKUgFInYogsQhu9soagPx9hyC6r6NIFwIIvLPAzwEl2Q3FRj/nikW8JQv/5g3f+1FZyozDiWS4epa6Poh3Vm9bbZFnUY8dMSMgUDsaqx60r4g4hIB5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(478600001)(5660300002)(4326008)(316002)(4744005)(91956017)(55016002)(9686003)(110136005)(76116006)(186003)(66946007)(7696005)(66556008)(66446008)(66476007)(33656002)(2906002)(64756008)(86362001)(6506007)(8936002)(52536014)(53546011)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SmB04OYeW33MV9VAFI3LQ539fmqOCUuOh8CCH1ds1m1Ntg8tH0f+AC03xexNnbQy0rGE8x7/csb1d0lX/ieVkCNaAw57AclVeoXLjr/zjvmKYy8+5S9xAPYtuKfTjeMRMVyx6dLLnMzKm8VybHvYDxO62Gu/WhuHJfgn+maPiy1l10czIBAbGm4M0aCFuQ2s5hcNIqkpRIXJld5DehDGz1hdlA/HLuFsUSa5lPB1LADnay3juhuTAIvusN0apor2TTKPdCDkHKfcXNsO9p+PH8XtEHDYdOuuiECxljJC/T/y/GgwbwF7e5vrr0mM3gud8kpLJuRWmHls5xBzGjqrdBUpuP9yJ/zWvRfKZW67fFIgVciQf/M0ZzIM/eoZO9dUPJwExQ5PXPMkGvJcRMPPfqXrFsaPgckZtyyzaCCGEvu8Rozr6vCMnkYDBltVAZaPLFu3cJ9GzyMX17eAOZmL3blHuDdJTKPGrraT0DyleU+tpbxtPX5+hOeE6h1vX6aAo6SF3aRz6vqSHPbLG2aKfiWVnvaBJ3QmIj3JxQUkm2dAMX42cRkDdBw9ALpDvRbp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47a435-f280-4edc-783c-08d818338c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 11:41:35.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m02dVWWqfwUVI4MIHXQ1j2+qTj65JY5nzZpP2ldWxU5N2NO+guHECUHUEtilGsxZmHKuAK/G1cReX+A2/s1HodLjuipqxlf++GVe1tj/HLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2020 13:03, Qu Wenruo wrote:=0A=
>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h=0A=
>> index e6b6cb0f8bc6..161d9100c2a6 100644=0A=
>> --- a/include/uapi/linux/btrfs.h=0A=
>> +++ b/include/uapi/linux/btrfs.h=0A=
>> @@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {=0A=
>>  	__u32 nodesize;				/* out */=0A=
>>  	__u32 sectorsize;			/* out */=0A=
>>  	__u32 clone_alignment;			/* out */=0A=
>> +	__u32 flags;				/* out */=0A=
> The flags looks a little too generic.=0A=
> What about extra_members or things like that?=0A=
> =0A=
> This flag really indicates what extra info the ioctl args can provide,=0A=
> so a better name would be easier to understand.=0A=
=0A=
Maybe version and for each new member it gets incremented?=0A=
