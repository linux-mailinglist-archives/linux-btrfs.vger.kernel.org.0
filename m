Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29955B00D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfIKQE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:04:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3520 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728825AbfIKQE4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:04:56 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BG4hDe006515;
        Wed, 11 Sep 2019 09:04:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0Kozm37N4qLP//SMhPZjk5++lLQLEFnwYpHrp2qilFo=;
 b=EGxvj+JxwSdYJNcfLk6LxMaXz0urkIMa8qxZJQTZNvbZw3EfZyCxZHz6uFdUjzpGifgB
 BrzDu+1DzKpcIKpZHcT6BBIFnOldj0SRswSxlZDG0t8umEIMkVf+IczcmocXXSvmvp2J
 LZMzsGQJ8O4c1HbNkQ2yXlOSWk+TEcbaKd0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uxqew2v7a-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 09:04:52 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 11 Sep 2019 09:04:37 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 11 Sep 2019 09:04:37 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Sep 2019 09:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK7VM06kwJJQ/h+E8Alxl8a4TDKd5bU9MLGA13c9ji4tIheHxTAUjbkWRsso6PkwwOiylrWQ/17ZlOV+zR8UWmzI6tHIyJjfM6QIHxC/NZBcES1MkQ6Tr5EtmM2wR88u1mDa32IgKM9EIKCPfLP7VYdu4dPnQQHvMlLYo2oNQp5A7I1bk3ohawMzRk+egYC/02ABQHiIdEeRaHYx+OmBWSwv3YCtwJAdM5DFeLwX9R+5LCx8B3RUSu9IeQmc/M9XyCONVM4KW88rV3P4kei4l83Li5vFIEYXU51YpEcEjYhKoZBNWrxvVNJhv/TM4mH1gQmz2XhQYbVu7UITsnzXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kozm37N4qLP//SMhPZjk5++lLQLEFnwYpHrp2qilFo=;
 b=ZoPKSyGPF/mkZ2nT7isCrjovPWEQJ+9XAR3odvk/PqCYen8kjV8HeB4f0GuoDK+Pm/O9FCPm9FydeuAKd7QfVZCpbdkwBikaet5bVGFvP+kFp3/MPOSXzmYxQrbcbAdT6jdlQ1dUwaEVMD7OaAHpbU8xic0he+fAQPycfMnxsTysVTFeaHMBvAqIyRxWnopuhedJofUr0IKUUxYlrJztUZVUcnV4Y7Ypk0EhUqKogOWFIZGfynSOS3IH3WuTIf8BSnRP9XzGFHssY84y+NMasdiFYN++QtzrTTRHnolzr6yHTDAQENlIDGB+Km3AsYRX+I47gWpG0oPounr3d3C4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kozm37N4qLP//SMhPZjk5++lLQLEFnwYpHrp2qilFo=;
 b=bDKvKYETqmZp3s3ECa3bI8xAS2o/S2PXb10PTgZslEJtealB74B+Nta9G3Yj2kyk+nInUQbn7DoDkwEh0qcUgrCI8SakLx2/k8JTNCbKPOMaUjMNp0RVL0ztBo1HTyxrhWgXOB/qhsiIZ9VmkDvDqxqM/YzDUxn3pu0235fvxFM=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1257.namprd15.prod.outlook.com (10.173.212.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.17; Wed, 11 Sep 2019 16:04:36 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::49e0:1c1c:5b16:8cc8]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::49e0:1c1c:5b16:8cc8%7]) with mapi id 15.20.2263.016; Wed, 11 Sep 2019
 16:04:36 +0000
From:   Chris Mason <clm@fb.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Dennis Zhou <dennisz@fb.com>
Subject: Re: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future
 writeback attempts
Thread-Topic: [PATCH] Btrfs: fix unwritten extent buffers and hangs on future
 writeback attempts
Thread-Index: AQHVaLEH2k+S1x5D/U2kXTADExohWacmo8+A
Date:   Wed, 11 Sep 2019 16:04:35 +0000
Message-ID: <18E989C2-3E39-4C87-907D-EA671099C4AE@fb.com>
References: <20190911145542.1125-1-fdmanana@kernel.org>
In-Reply-To: <20190911145542.1125-1-fdmanana@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.5r5635)
x-clientproxiedby: BN6PR0101CA0024.prod.exchangelabs.com
 (2603:10b6:405:2a::37) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::2d5d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a405f1d7-da33-4902-dd0f-08d736d1bdcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR15MB1257;
x-ms-traffictypediagnostic: DM5PR15MB1257:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR15MB1257E9B9A0590D6E6FC455C4D3B10@DM5PR15MB1257.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(52314003)(189003)(199004)(6506007)(2906002)(6116002)(36756003)(229853002)(53546011)(8936002)(6486002)(50226002)(2351001)(305945005)(81166006)(1730700003)(81156014)(8676002)(7736002)(446003)(46003)(486006)(386003)(2616005)(14454004)(476003)(102836004)(11346002)(2501003)(76176011)(256004)(14444005)(6512007)(6306002)(99286004)(316002)(5640700003)(52116002)(478600001)(966005)(6916009)(186003)(33656002)(5660300002)(53936002)(25786009)(6246003)(4326008)(66556008)(66446008)(71190400001)(66476007)(86362001)(45080400002)(71200400001)(66946007)(64756008)(54906003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1257;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cayoHZDEKe3GBnnbNKOKoiLuzAl2BUD/uhR4UGDPhSmeme8+GydCx7qUSiqMtRK8ygTT9+oxdMZhUVvFS2hda2UnA2akGIY25x4WnwRS2wfGPW4ngn8Xl2bLMPROJtYAwy4zf114ps/9h7ETJnbMeV1o+Bff8Asx9WIs0FJho97xbaxN3lB26sABlZ5hZwsEhkiVh+eT55g7y9RB114nN/m4Ehb6zOO2kpF3OOMVlTzZmbj41DYDSxxebmpzy957StLiA10y0a2JdhwyxKryI4sudoZ4sO/WZjs4pmfpIm9PcxkNZbsIa0AzQrOlXC3xc2Qai9Bqzc0ueQuEFlz3B4BHgSSRFbOznOX5MgY/jPaEqvwbHxkrFEVTU4TOi1LVvOJiFGgBBv4Ieg8ySxQXd0QrRSsnIH9eUdyfmyrUTyo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a405f1d7-da33-4902-dd0f-08d736d1bdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 16:04:36.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcQA4KDgRyVhCxLAMgEfO72e0iuY72mdywCFgaIKUYkuvyS0zevljNu8cSh88W1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1257
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_08:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909110147
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11 Sep 2019, at 15:55, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
>
> So fix this by not overwriting the return value (ret) with the result
> from flush_write_bio(). We also need to clear the=20
> EXTENT_BUFFER_WRITEBACK
> bit in case flush_write_bio() returns an error, otherwise it will hang
> any future attempts to writeback the extent buffer.
>
> This is a regression introduced in the 5.2 kernel.
>
> Fixes: 2e3c25136adfb ("btrfs: extent_io: add proper error handling to=20
> lock_extent_buffer_for_io()")
> Fixes: f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in=20
> flush_write_bio() one level up")
> Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> Link:=20
> https://lore.kernel.org/linux-btrfs/GpO.2yos.3WGDOLpx6t%7D.1TUDYM@seznam.=
cz/T/#u
> Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> Link:=20
> https://lore.kernel.org/linux-btrfs/5c4688ac-10a7-fb07-70e8-c5d31a3fbb38@=
profihost.ag/T/#t
> Reported-by: Drazen Kacar <drazen.kacar@oradian.com>
> Link:=20
> https://lore.kernel.org/linux-btrfs/DB8PR03MB562876ECE2319B3E579590F799C8=
0@DB8PR03MB5628.eurprd03.prod.outlook.com/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204377
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent_io.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1ff438fd5bc2..1311ba0fc031 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3628,6 +3628,13 @@ void wait_on_extent_buffer_writeback(struct=20
> extent_buffer *eb)
>  		       TASK_UNINTERRUPTIBLE);
>  }
>
> +static void end_extent_buffer_writeback(struct extent_buffer *eb)
> +{
> +	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> +	smp_mb__after_atomic();
> +	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> +}
> +
>  /*
>   * Lock eb pages and flush the bio if we can't the locks
>   *
> @@ -3699,8 +3706,11 @@ static noinline_for_stack int=20
> lock_extent_buffer_for_io(struct extent_buffer *eb
>
>  		if (!trylock_page(p)) {
>  			if (!flush) {
> -				ret =3D flush_write_bio(epd);
> -				if (ret < 0) {
> +				int err;
> +
> +				err =3D flush_write_bio(epd);
> +				if (err < 0) {
> +					ret =3D err;
>  					failed_page_nr =3D i;
>  					goto err_unlock;
>  				}


Dennis (cc'd) has been trying a similar fix against this in production,=20
but sending it was interrupted by plumbing conferences.  I think he=20
found that it needs to undo this as well:

                 percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
                                          -eb->len,
                                          fs_info->dirty_metadata_batch);

With the IO errors, we should end up aborting the FS.  This function=20
also flips the the extent buffer written and dirty flags, and his patch=20
resets them as well.  Given that we're aborting anyway, it's not=20
critical, but it's probably a good idea to fix things up in the goto=20
err_unlock just to make future bugs less likely.

-chris
