Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAAB231C9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgG2KV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 06:21:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24845 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2KV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 06:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596018117; x=1627554117;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qvj4rb+lz+4YD1we/sQa7Aw9moL5z9iZMMAb1mA6nw4=;
  b=S7+jyKptKRjn4OSUQtYgku6MqeFhg4cfGRr/GHZbSi7+u6rs+f/TEVCC
   QJm/Fwn089flMoBW14exj1cqK3lRhE/9WCzc5we+xYh4FyczE+SK+diDm
   dd4r/MBZxmrHye1+FRGVowiFXEgieAYPv/Z2/FyVk+yQHpAvSpKVvxIzu
   IxDIPyRiWDNxJRP/soLHVSPIxLFHlqrM817EdTmgg90GacWcP73L29ykg
   3k4dGy45RPa1Jv+E4UYn6NIbapggfYv/4Swo2Abtw3UsX4e//cZrReRsQ
   6K2GhNbzg+YKGHqPdtpDYpMYTHkgSPM+VyvWYuz5xDW4TZIbpqh8j5Ejz
   w==;
IronPort-SDR: Nbbyl/N7hFN3eHEDhgCt7gneJZnzt4XrmOG9yj502Ujw997Y1TvpmGHLBvvE4/xlxIl1dTApqX
 LSYAc0QRbEYnsLVWI5Am9rj4zWW2TKnFRs6bANuksdyIzJk8KxbLvMOu+2jmPvTVtvEABF9gQz
 rmzZPmkW9+F/OV6tS4KdSnFf0RGoqLE+a07Ia8anXB0HqlgDPnAHN7t+O7u4CtyRE+cOFiiTgk
 OM780MRhp5Vv3lQBx10fDiGREZ/TAprHj6gUJwK1WjnCyRZxTWw7DUQbE4JoWO5LRPQoitPspU
 8cQ=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; 
   d="scan'208";a="147949428"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 18:21:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGoaDfTwFdMCbNOlVbb2nlP9O0NkvfhrBsc1DuW6BdwZYu8I4ZQfVN77mjkP+Dh2O1gjeHHmK9KDQr3mm8gX+UJEuM+ENzNX3yNilZKsopN535hWDmw6j71N005weLCvPFhHcWIGAv+HTlt8NdSQQ2fldLafX694YzMhuumQa4OhyqAQ/ZVkV257zGj2vrLxYza2ZFKh91iFGkLD7V7Xy4btnNVRg9I+rhZM066XcHSINYk5qIsAs8lYWAcAinRMZUubSTApkr9ALi2ghsoV6Pe9jWMN92ZKlKvQvlxMpScEey0hgDEyYHjfnO6O8G7nD31Hluie4aJBkYRFbKkQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKh2DTqX3DhQuCmBD6AGCcAiCtf/WqnGr8Ldt1kHQ0=;
 b=c63ihrCaeTiiq7CCn7ediP6AajjWqp2/I8ajHS+WyUqO9uwsqIAVg1okldwYWbAvGTpuixy5WdJR4tT7ZYmzOs0b2ME0WMv2uzH01EceZL+0OWo5+BZGe4i7PipNglxoD2gfl4iGYC87FBlDq2v/3baSOj3zDnveBbo9Z60Mdes5rSiPU51G4S3S08Ck2s6ZeqiktcZW9+rB87KDG5vdwKov9rnuv7LjLE7tuW3RoU8crdyDiH54MqICzL96TituYM88UroxLsKEChVJ1LuI4npYkACCMEACIPxJFgk3ihvE+Df1pOVNNwdMIkA6Bc4NNzW+h0UBWA4YwXQTTwbDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKh2DTqX3DhQuCmBD6AGCcAiCtf/WqnGr8Ldt1kHQ0=;
 b=uYSQeoRirN0olnmsrk5VZdRyJfIVtgCD3YQkKBtOYHNMQ0sSIp+ZIxtLM7kSlQiAUlTQ5+vU1CgA6ieih4ShGIJdtBm0u+vC4GLhcvx0O4S8EYxqEfvHM+9wBkDbRy1Dh5mrBMgfxZe5kb8p1zcHv3eZho7IuVN/vQXXCOjDbA0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 10:21:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 10:21:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leaks after failure to lookup checksums
 during inode logging
Thread-Topic: [PATCH] btrfs: fix memory leaks after failure to lookup
 checksums during inode logging
Thread-Index: AQHWZYkn2Srt3Q5IeEqi75SR8/DNZQ==
Date:   Wed, 29 Jul 2020 10:21:53 +0000
Message-ID: <SN4PR0401MB35989603C16ED9184B30ABA09B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200729091750.2538306-1-fdmanana@kernel.org>
 <SN4PR0401MB359867EB5CFA751D2643A6319B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAL3q7H4mjfjLwQTPONkUR15Z_pQEksDgtt-YYC_vBe2cXctPzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44f78b14-b47e-47d6-7004-08d833a93748
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-microsoft-antispam-prvs: <SN6PR04MB4464B6A79AD6261F1C71524B9B700@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: De6LjC37f836N0MHfG3q0bOFjev5LZwt3MseOu1UqZ5ifklbOZmV5GaEAeArCHlGAriXL4QfksqJ+3wZXdZ9+/OGdlND+v2z/bnBg4k9aK0y5KUBIgbd8hC8c77MNs9kpsoGoY7U52mJudkeQyDx2yzh1gd4m3M+kk1zJZtbNPC5WMZeSdggcHhr7OdcZj65bENVYjwz6fTfIvwRDi6pgVt4jMmEupdd8di9ZdT/5h60/j0C0iLG3NLR0zMvbmRO6Y2S0dexrlAmlyLrWF2h+rtlAQGc+w+5v1pw5EsJhaWpMvF7K3czcQln6DivnxSJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(52536014)(53546011)(6506007)(33656002)(8676002)(4326008)(5660300002)(83380400001)(7696005)(86362001)(478600001)(55016002)(76116006)(66946007)(2906002)(91956017)(66476007)(26005)(9686003)(66446008)(316002)(6916009)(186003)(64756008)(66556008)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jmqxeyPnqH2mNSbFIFW7+7EMHGQCvnYgM0YFDj+Db1vsBI3KWWBTAUHaRntob2pBrzBMOqapp+rtLq1SV/m0QNMRN4ubf7+za5NsFmLpzT2UYXtxc6/N7roG19AaSn2zt6CuWXYnmKFJaMJi3Yc5CTxWTvVO/Y/4NK6BWGK9JzpcFHXHFVZ3DiDQAG5JceUJ1jh7jQ6XH+1IafQwaa7sZqYnoUNnRXoHvv/1Udj8i/TW//NbgvFR1TTi3Df6lNbf+uyNRlV5AIisa9z+zqDxe4uOZ1BT8XqCRT0kLkDUTfIfhVirSi7dqXeH0y+ucHuoT+2H1Z5qT5qrg2j9FdIuTk5/IFRcXk+DfNL94d+yd8PuY/960GRObgItp4dWyuQdc2ShM3dzN1pOxjGPGV0B+Lw9YUuSEI2p7xCzVEcgAfCKLr1av95PX4/ZgXa1iv4IH47Hwe6ZgtTC9gNo37G6ZhvWpXoVmbz8YdyE8MMBGaFHLDH/TIuz/rayKE1irEmb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f78b14-b47e-47d6-7004-08d833a93748
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 10:21:53.9181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBI8GLN0Cz+e/AjytLtbneZCX/LrJ8gANP6jNCe5TkGbALZACM8c+IJsj4UY/y5ZcA8jslL+egsPmqZ6IVbK+pu1yax/KhJamQprTlZ5ZgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2020 12:18, Filipe Manana wrote:=0A=
> On Wed, Jul 29, 2020 at 11:09 AM Johannes Thumshirn=0A=
> <Johannes.Thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> On 29/07/2020 11:18, fdmanana@kernel.org wrote:=0A=
>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
>>> index 20334bebcaf2..f1812f5baec4 100644=0A=
>>> --- a/fs/btrfs/tree-log.c=0A=
>>> +++ b/fs/btrfs/tree-log.c=0A=
>>> @@ -4035,11 +4035,8 @@ static noinline int copy_items(struct btrfs_tran=
s_handle *trans,=0A=
>>>                                               fs_info->csum_root,=0A=
>>>                                               ds + cs, ds + cs + cl - 1=
,=0A=
>>>                                               &ordered_sums, 0);=0A=
>>> -                             if (ret) {=0A=
>>> -                                     btrfs_release_path(dst_path);=0A=
>>> -                                     kfree(ins_data);=0A=
>>> -                                     return ret;=0A=
>>> -                             }=0A=
>>> +                             if (ret)=0A=
>>> +                                     break;=0A=
>>>                       }=0A=
>>>               }=0A=
>>>       }=0A=
>>> @@ -4052,7 +4049,6 @@ static noinline int copy_items(struct btrfs_trans=
_handle *trans,=0A=
>>>        * we have to do this after the loop above to avoid changing the=
=0A=
>>>        * log tree while trying to change the log tree.=0A=
>>>        */=0A=
>>> -     ret =3D 0;=0A=
>>>       while (!list_empty(&ordered_sums)) {=0A=
>>>               struct btrfs_ordered_sum *sums =3D list_entry(ordered_sum=
s.next,=0A=
>>=0A=
>> Isn't there a potential that ret get overridden by this hunk:=0A=
>>=0A=
>>        while (!list_empty(&ordered_sums)) {=0A=
>>                 struct btrfs_ordered_sum *sums =3D list_entry(ordered_su=
ms.next,=0A=
>>                                                    struct btrfs_ordered_=
sum,=0A=
>>                                                    list);=0A=
>>                 if (!ret)=0A=
>>                         ret =3D log_csums(trans, inode, log, sums);=0A=
>>                 list_del(&sums->list);=0A=
>>                 kfree(sums);=0A=
>>         }=0A=
> =0A=
> Nop, when ret is non-zero it never gets overwritten.=0A=
=0A=
You're absolutely right, I'm sorry.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
