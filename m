Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2827CF0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgI2NXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 09:23:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36043 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbgI2NXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601385829; x=1632921829;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=48EAxbAZXgL5NG4OwfunWaV6u7XkgjhC5OqYEw1gK58=;
  b=MQn3FBDPQFTI4900Q9v4OtVaCZu6Bsdakdb/VtKDR7dmrB1AuEyx+yBs
   vDsOcFGkjZO6bVkySrS6U4cm9mH5LnXdEUa3rjXuTrci0DTQ7AvozIa/X
   xQlc0X3NK4oQfxtOk4Qf/Rdo86DHm7QZ74EpDu3Wp4YnWhotjvqpUrwiD
   d9Wmq8BDe07XcULvg5Ii0F4ShSTgamMggFSZS9XiWK9jxGsb3KWPnsFJR
   K8MbFBC+Wss9xeoXh4SBukrFTlBTXt2rxt9O6xsrRrplM+mZPNFsJ8lJw
   smBx6o3WSafE3C0BfmopdZMVpnJo/3ny3CRCX2zK0aXy2QDoQsPQ12a0L
   g==;
IronPort-SDR: +Qh838EPaBHPDfE41numHdRoFBWKQocfB5DkyieBG/aIP2T9/xBro11CtLt37+49BiTq9S8TIM
 3vSXjhMIByFy25grTDTdJse7YCXU9a2J7TByN5DePWLV/N4vwdPh4UB7meVMoTFwsTn3ZKfJed
 udExN0FK6XRyS5Rs0ac60M+JyqWlEPmJav2bo1UHv4TNMB3Tk4qCMzHi3wG/BQQgJEvWHAmY/l
 hH8d+gqitpOJz5M+08qhufcZoBelZ/HQDNelBqfxjx7TTiaY0+kSHMkShjrc+U6MhBM8F29apa
 MLY=
X-IronPort-AV: E=Sophos;i="5.77,318,1596470400"; 
   d="scan'208";a="152927012"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 21:23:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ6H0vf6AJfBn6QYzbv0dI3TKpSLyK3Dxa8PfJKquTmJXuSpsWtuJld461/k9FeWQ4UEae7IFvpfA/QNTdHuiVcpJ18jKrgkxV8eatt2oom+AVd+JQ48LQf/25blnjdWa99B0fgjc1mRkVqf2WiFRYMFDNFjq5Lzw+eaEfJXWn9jk1PqRYJb4cQY3WbvV/SsVSe62sDAHLZ20mu4C9FtvD0+zpz5u1PNbQEUmbW2DQj/Gzcot0mEwlp9IZrCwO8rzuTlHJTPEBFjs3uJg17UcrcukfzzzsCBlhI/FbFdtH6WgH+FxB/exEhk11nka4lBO3Ql4jaz8q5JG3OlYF/OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDMI9U7lAdKCbEq9RewgdLwQrQUr3fFBPg0iqSg3PP4=;
 b=jxd/wr5h8jaV0Tq16+0MwACmfp9Zi3kDkuLzX+7lHSv3PNMYHoMKTVYvculcNMCtuCxGRpGXmaPJgnkkcCo9tLPJUscS42gFWm5J6fHexAYa5vlZK5SKHN37QWEHI/y5pswldTr9OvBOMfaHqjPFVS+U+xPis2E4BXksXMz20/p9CSISK+DXoMaQkhmLUvRmOy/tVwRsyh5nJVMa8XDDhjSwmoakKaC7y0Y4T67yMwdJxBgsK4ZxwOkucXYSVbYmEN5S7xXTLpuZqC2x2dESNZT5sBWaG1wJJgeyzpuyOeA19lSgSm7tAuEoLiAzsPBoLGjTfQh9oQyAULrvwNGEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDMI9U7lAdKCbEq9RewgdLwQrQUr3fFBPg0iqSg3PP4=;
 b=F+8G561CxkqaW63fFDfxMdQv5LDaWrMoXP6fU8Z/6mDvfVj9wO1PmI6Nr8i4JpEFI/eVqgGVlH7YC7o45hOvJ6l+taSS9xOeavEtj8JDV0iXKr++L7/wA0QW2jFbdUJMuDn/CNqGnkmVY7j5N1Q2zAsCNJm5NtRqfVg05GS9Azg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2141.namprd04.prod.outlook.com
 (2603:10b6:804:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 13:23:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:23:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
Thread-Topic: [PATCH v2] btrfs: cleanup cow block on error
Thread-Index: AQHWll+fiDf3UbfKw0KpZdrUmVZmGQ==
Date:   Tue, 29 Sep 2020 13:23:46 +0000
Message-ID: <SN4PR0401MB3598F30AEAA3755072C0DF079B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
 <SN4PR0401MB35983F92A10521F7CE5F891D9B320@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200929132107.GF6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:18a9:9f8d:df16:87f1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d262e08e-7ad0-4666-fdfc-08d8647ae508
x-ms-traffictypediagnostic: SN2PR04MB2141:
x-microsoft-antispam-prvs: <SN2PR04MB21412702B1980AAED93185DC9B320@SN2PR04MB2141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +t6kpMghQGsazMxMthQdBB06bs/icSKI29ZthHxu4Ti4wjAaUHnAg2EbpCQCzF0VkSVZA2za+dCqBJoxKwAMGzQ3s+nNgdciwctYBzkmGG2vT8fyIjlm5XIWl+13edltJIqFksxr/z+id9utCkMyki5SoUk9eNvr7rnKdHeH5jEBUM4nA19E/rTQmxrGTcSviOpl73mp0fSKmhaxfz+AiW9QEh0BDkYwi1GUHuIAh76SapKtmXQy979pziDjCkYj5W3oedv3720NLXjl28bvtLGR9tvMdsKhVT23yBUG7pw9uaLyXCSWLFL6qpgM9Pb3C/9rK+4wRXNIblf7TwQeMKgYpjX8atcGD+KPgWVRQHVj+HMgVIR7l9MMjFs4KZhEZfuX5wenBO+7WOcps9Vw8YbCs7oXKd54+KccqeBu0lOdBRgmgmme3/ikQ7/81CYc+I1TeUXGpUCzFBMf/MPBHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(16799955002)(86362001)(33656002)(83380400001)(186003)(54906003)(6506007)(71200400001)(7696005)(53546011)(498600001)(8676002)(6916009)(4744005)(76116006)(91956017)(8936002)(66946007)(966005)(64756008)(66476007)(5660300002)(66446008)(52536014)(55016002)(2906002)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3RKNjPx3KpIl8PXEjzrZz41pYZJxiuUeTum7ZW/X/cftf8xRBEqYCQIXcqn+HLFX6v2w4ll8MCTlRkayBubD2t1w3rDu+6DuMcgiC3QkYN6PDKTXI22K5KKP9Yd+85Rd5Vttn58hll2oKZ2Tcm8kr5lTgdQjLmEoZHkbpTHdGpN637xzFVxdl80NnzZventtMVRxSNFBnOcpswEzdW5gQxBbucicGtrA20odysUbWADNpoJXXuh0u94VghgwFKNuPGqfh+dxt6w6BJPWnpriELpkiNVm71g1ZSWqFKX8UdbQKKBtf7kK9U36NplOm4hWsudCE9yPLdXih+4i5TqpqMgTYjlNXfov/EruZxn4W9PQ4VCK7uCRsNMtf6PFqK5VGKpf1IgsflKKoG8/4Nb0M7+Yjh49ZJmf7osrJaOFgmjLnY77ZQhQ86eASOjRNmbX3FurCBYmH0EAK/usi5jv27j14CjhGUy309M0+qaBve1nSEZoig21UYOjjJbB1P1sKMgK5Ql5v2ChRUcTgMJz1DoOYVBLeMf6Y1mwJA96arD0soTGX/V/eVqGhixxRTu/BmCUdWPeR97fYsRBoN3FDe7rWVKvrBbpbWwwh4yX/LMh4QC5+zeT8sQoAIeizf5riXtaNnB7GQY3SJHyuFeV3ohNB0weIB0dA3O1kqf0+NluuulaXPQPO29IbAfPZl0mrHh1Wx9e1x5gPivNW63nsg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d262e08e-7ad0-4666-fdfc-08d8647ae508
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:23:46.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puwAnk7Pd6v4SAG3ulPEcBaO35IJSc865Wg8OiIcYC7gEDQEvZviAz5I09QQj3uycYuHaz6dg37sbUY5D6OTAHyN1fJnXlaSvA1Rn2IiBTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2141
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2020 15:22, David Sterba wrote:=0A=
> On Tue, Sep 29, 2020 at 01:16:50PM +0000, Johannes Thumshirn wrote:=0A=
>> On 29/09/2020 14:54, Josef Bacik wrote:=0A=
>>> @@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrf=
s_trans_handle *trans,=0A=
>>>  		if (last_ref) {=0A=
>>>  			ret =3D tree_mod_log_free_eb(buf);=0A=
>>>  			if (ret) {=0A=
>>> +				btrfs_tree_unlock(cow);=0A=
>>> +				free_extent_buffer(cow);=0A=
>>>  				btrfs_abort_transaction(trans, ret);=0A=
>>>  				return ret;=0A=
>>>  			}=0A=
>>>=0A=
>>=0A=
>>=0A=
>> I don't want to be a party pooper here but, now you have this pattern:=
=0A=
>>=0A=
>> if (ret) {=0A=
>> 	btrfs_tree_unlock(cow);=0A=
>> 	free_extent_buffer(cow);=0A=
>> 	btrfs_abort_transaction(trans, ret);=0A=
>> 	return ret;=0A=
>> }=0A=
>>=0A=
>> repeated three times. I think this should be consolidated in a 'goto err=
' or something.=0A=
> =0A=
> Hah, you think _you_ are the party pooper?=0A=
> =0A=
> https://btrfs.wiki.kernel.org/index.php/Development_notes#Error_handling_=
and_transaction_abort=0A=
> =0A=
=0A=
Args, you're right.=0A=
