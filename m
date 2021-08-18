Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7913F010B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhHRJzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 05:55:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58213 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhHRJzx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 05:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629280519; x=1660816519;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yt83oxGoL0+sTxc9dzBH9dpxKlCtwdjwl1ftd8iWHPE=;
  b=L9cCF6TKboC0DQJEqCuR1nMqF5uuslt49cCBz4LYrTQgG84eA0S4KZnr
   hd+VLpkc/9XBVyR7JV+rjOhyUjrveoZx5YaDPX9r2XUBN2zjjzcMqWSnU
   iIz8LC/r3dPhp1CFZrQcRLf4uwQXAjdNVShSLg6+t8dxKge3eMwINgXDQ
   f+LBZduM+9NCcKYvnpz7iIDKAwsb07KbV+FmJWNGOOKraN4fiEHhTk3uZ
   kVF3j2QS2yBQ92q5u75cefR8EckIZ79lBObqnd+5cTbYBYuEqAMJDlnid
   oWF3eI5q88ZS/2o3dUfofCQEI5ekyaInGZ8PRuRyb3j2SwJUZRDbk8I9s
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,330,1620662400"; 
   d="scan'208";a="177628466"
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2021 17:55:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdRHVf6ENGS1K9ihHNzulWDMEsICqOMGBWt7qnrBaDHw4wyk5WKRXkTglOx251Bc0ZKO7ykz9fmaqdDb2OC4hf8qty8HvdU7jPLuGSi1yA8NY/u+aIbs7dcpgV8kTwYslQcQsJ/11s8ZUbVJQyCSXxXKtzmHBb1kmtlQlLoqxnzXqGe2EmVjyqg4NDhDSlW/MNtWsJkpRSMJdQv89xD5Q1K8ow1G+zJ/G3xtVwBgEYCmelHg/Gytu15/WGvb3K9HjTAgBw1OkCAC3Zpj+sJl22ie/SSvmfBpEAaNR2MdroZPckO+9Y+gxfFpE/2lMFT6wZQ7M8xQVhlpLlvydfneaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt83oxGoL0+sTxc9dzBH9dpxKlCtwdjwl1ftd8iWHPE=;
 b=dbMUH5ZcjjzRQDYYLJTA9jKKH3ocy+0FTR60z7996FaiXVM/CYGHW2bfHgLzSu8cTfTu/8sOOQRfRwqDujtOr9fjl5+wNXo7pGZ9XHFaXNw2H//oXw3V1Ye//Gm16BcM5wgd0zAWBndDtD+KjfoQn2iGCcdAsj9yswZU/Ale3uG1Z8PK65kjupmV7ITIm2so599oTTZhVSKJzznqns9yDiFcDk5rI0AHsZv/JfjdPL+MdtDrOPlCE1cQp47nQj4cLGhzZnI5ood8F2sfTKdcE81AiWM2kw91QfaXRIyy0twvFfJ/aHxLNZ8v79+l8bD0MI9ir/8ZrLsTu0INxRnpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt83oxGoL0+sTxc9dzBH9dpxKlCtwdjwl1ftd8iWHPE=;
 b=V11ID84/C2yUFpDGLg43s/HAwlEnTRpElY2X9r98YG4O4yEFD4+277o0YtQJoUjSxhYbH9yIRtO1FBOMK9WQLU/rw2+VcFBJA7NTUUrX8MwzlwUgycqFk4cMuv/gf6RPqN2uN54bBR9wshdGA/w7fgr3sKPO78o8I4EX9gkWQwU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7221.namprd04.prod.outlook.com (2603:10b6:510:17::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 09:55:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:55:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Topic: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Index: AQHXj4GI9FRDQitxX0OL8mIJT/tTOA==
Date:   Wed, 18 Aug 2021 09:55:16 +0000
Message-ID: <PH0PR04MB7416B1429DC9D86ABA9C5F119BFF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
 <20210812142558.GI5047@suse.cz>
 <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210812145017.GJ5047@suse.cz>
 <PH0PR04MB741690FBBB6A43279E9F1ED89BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210818093648.GP5047@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90e1111c-c85c-4342-339a-08d9622e4816
x-ms-traffictypediagnostic: PH0PR04MB7221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72213FF6951A30DFA85230FD9BFF9@PH0PR04MB7221.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 903r96TC7nI/jWdlV14Ovkemp75GWt25wEMpyrl5vUBi7RAwLwSbqSRqG83AJfJL8UGU1y0QsB7ipMThiPGVMVdR/0qoMirpRFGFIg7nTCMU8j9t9PKJgm+pPLE1knhCUjsnmOjDnEiHv5GLy6Lby07nXKKgkMR/zwAOJGFi6x/cWUbiEkIKvCJMejrc5RupPTcTb54VJmP/6qMckhAtKSEQSGitFnjfukD0+psrsy5qNPYeGVrh/N4ztdjlBiU3boq4uKWxp2l1R8+h7SX89vGFx982ONj30XT+xe6gEoJkrcM2ZxLx5h6CmO7DeTsy+aZXTWoUpekG8irSxYZQvWgq9Sp+oaFqP+G3n1UNckc6jaXpfBuJ8wk21enxAjqy4dPmPKvHKMbgynb3VpH3YM9St3uR+WVnM9XI8mVE5XTHOQm0ldgHwuYy8DqT+Z4iI/UPW0M2k6IqbvE32l8XFS0v8QE7l2kehen+H+D+YHKiTh7w0OIV1aveI62Qp63YwwE2UNjPY/SXRILaVbJtSj+LNalcokecVyYuXycaCLjW8PTE8OJic7pjVrpv9e/1Z/i5AcGnwoud/jXdO6PFeU2hpnWY332kkeI8TwPhE2cKbSdNiAVwecf+xTiCtAuyBHsOmZz0U8w/9zKra9TJfhBuxwooSZg8hixz1i3nnEvV9ahTalcf03k/Z+Xxg9feYSuzWT6JmruwxAdnRJeP5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(508600001)(55016002)(122000001)(71200400001)(6916009)(4326008)(64756008)(76116006)(38070700005)(2906002)(66946007)(66556008)(52536014)(66446008)(33656002)(54906003)(66476007)(316002)(8676002)(86362001)(53546011)(5660300002)(83380400001)(8936002)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DKHfjbwdcu9alNtiM04dKGanFsviO3J1HEdrHGOyDkLCsT6GexIzefSTGcTP?=
 =?us-ascii?Q?gjXjR8cAJeSnjmGCknxD8RHhfcBbfEDQMydqyOfjuXnN7JJQCld6/Qrb1R4m?=
 =?us-ascii?Q?5rZTKQs3v6ad004NMtK7h6sKyAdiV2Im4xO/ylaw21e+L95qzUFC+JOa+CV1?=
 =?us-ascii?Q?NSELGHeD3ec9g6lG1EWob8ft4V5KRAnx4yAH15e+8fikK4BDgZHmIWPLlI9x?=
 =?us-ascii?Q?LKHyL2POYXwUjoLPa2QAUUgUpy2vUo2K6DMHi8gIQ2e/1G7Tywyl1yb0TuRf?=
 =?us-ascii?Q?TbFuIr3ik+FrJqW6veadkMIOGB8eNslhAcJqj+7K1XqZcnLPpB1PZWi5/bD6?=
 =?us-ascii?Q?IvpKyTZpwkXM9isKWN2ec3NrqrieXpJRzTZVCP6GSMgC6FaaIEu2ntSGOjUS?=
 =?us-ascii?Q?XMjAkCzUqS5qEUqCqS7ac5l1QqqXp86GnbAj7QKUqQT+lDS7Qi9wNsv/dQGW?=
 =?us-ascii?Q?irkNG/akik1kaWcQTFL6CRPkJWHCjONDa+3Hu49pJUW3bJYpD2UmRuALORmF?=
 =?us-ascii?Q?TA25D/wbXwuT0Rud7UdyeAQMYnCkWKBfwVJSRCJ2QsqBplyEE9mReYKXsRDu?=
 =?us-ascii?Q?3D5+V0/1Ag8z+da7coID4c9QUZpcjkQzCp8bkh/Mu7LMcrVvDlqjITsSfwFd?=
 =?us-ascii?Q?ihpGIJMbS7RQYkASsmkXK9iVGZ8yW+wxgtntwrzTbizu5P2RflSg3N4dBHUD?=
 =?us-ascii?Q?rERw4eAhLVXPUw9KUnhm454J7/akaWkr5pPCe565Kp5CkutYPzniuxsA8nD0?=
 =?us-ascii?Q?k5FbOhYtxbW2UstyI6lxwTAiFx6cx9Ej5xL7cNAF2wPJFywB3xTQV948ILRC?=
 =?us-ascii?Q?b2hyIUHAPAAZk5yGY5c/MBfGfX2FrRQ+kdrooTlKPZYWjDPKcfqJuIqgyNPZ?=
 =?us-ascii?Q?OSx74gP7KDi0do+ofhw8ztXmomvWb7GbDZqEtEdtkvQcrZ+48bMMhzNAbihH?=
 =?us-ascii?Q?uet26BZP1OXYMkF7XR7R6+GKUXO4RzCUxm6RTz+7FPHMn+rxxUmxAOnbnYON?=
 =?us-ascii?Q?x62QKDeftiHUHuwy1m8oKfbZgEf0t5CR2rXzLKtN7dXcYbjTFDOyq2Tjf5WR?=
 =?us-ascii?Q?WuAM26LND7jFAmVcw/u8XZ9xsn8Rpe/W2qmMhUbChFH5/E7YBfwdCADv+wMq?=
 =?us-ascii?Q?OoeNLXSJD9J9TFEfKrZnfHTgBAXbaYUOzNljPl1dTG6S3qJZgC2NWqN5MT16?=
 =?us-ascii?Q?NglUaBsdrFATLLOkb6xpaQcAVTvj/aiPJez+uHeN1Qpnwibea+qkLggwMcEE?=
 =?us-ascii?Q?pL+sNmpMV/pGZMlPAkkfbyWVIJAR6Ai0KezisTiOIeasfbklij35KkFYKAn2?=
 =?us-ascii?Q?FFA4xOpzyDJDGV91rjmXPDXi2sG9FBn189izkSGmaXDmXsZDZEO7J+oQsHfF?=
 =?us-ascii?Q?ejKnK6Lhxq7aCyoOvK58RKn80ha8emWM1wfMFSmsyF3CYJoMuw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e1111c-c85c-4342-339a-08d9622e4816
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 09:55:16.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSO9BAJKRnxrWCBVpTz8YYzw4FvUwXwQJDfW/g9JE4AgORmXa2KxZsxVKSHOI87cAepJQLS/F9PbDdi+umrImThEag97dYZdQg85K/wYFcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7221
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/08/2021 11:39, David Sterba wrote:=0A=
> On Tue, Aug 17, 2021 at 02:21:51PM +0000, Johannes Thumshirn wrote:=0A=
>> On 12/08/2021 16:53, David Sterba wrote:=0A=
>>> On Thu, Aug 12, 2021 at 02:40:59PM +0000, Johannes Thumshirn wrote:=0A=
>>>> On 12/08/2021 16:28, David Sterba wrote:=0A=
> =0A=
>> I did some testing with the inode lock and it looks good but does not =
=0A=
>> necessarily fix all possible problems, i.e. if a ordered extent is being=
=0A=
>> split due to whatever device limits (zone append, max sector size, etc),=
=0A=
>> the assumptions we have in relocation code aren't met again.=0A=
>>=0A=
>> So the heavy lifting solution with having a dedicated temporary relocati=
on=0A=
>> block group (like the treelog block group we already have for zoned) and=
 using=0A=
>> regular writes looks like the only solution taking care of all of these =
problems.=0A=
> =0A=
> So that means that the minimum number of zones increases again, right.=0A=
> If the separate relocation zone fixes this and possibly other problems=0A=
> then fine, but as you said this is heavy weight solution.=0A=
> =0A=
> We will need a mechanims with a spare block group/zone for emergency=0A=
> cases where we're running out of usable metadata space and need to=0A=
> relocate so this could be building on the same framework. But for first=
=0A=
> implementation reserving another block group sounds easier.=0A=
> =0A=
=0A=
Yes but we need to set aside one block group/zone for relocation anyways=0A=
to make garbage collection workable.=0A=
=0A=
I need to check progs if I have already included this spare zone in the =0A=
list of minimal required zones. If not I'll post the progs update together=
=0A=
with the kernel side, as both need to go together anyways.=0A=
