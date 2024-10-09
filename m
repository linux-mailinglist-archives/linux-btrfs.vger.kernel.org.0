Return-Path: <linux-btrfs+bounces-8722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96B996E6D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AFD1C22D45
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8619D097;
	Wed,  9 Oct 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvSnDEtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9318BBB0;
	Wed,  9 Oct 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484979; cv=none; b=aRo12ZH92vC1xreMDYTequIBCBLOKIijRIU5SMI7WavpwO5jelidRleZ60DtDrIRFUH2FjxTj8n+i2mb8yygUOVvq0K5bn9i67LovAx0WM3kkx92muWXpsKGHsR1Uc4pB8PFQuKUX3yGTsHwnqg/Kxr+ToL7DvGRl2jlzleRdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484979; c=relaxed/simple;
	bh=6JEg1IWQ9xC5kwBpzTwz9Zj3qaAc3eJWc5MRgFK88fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTPMaLY6dYCKwFWJ4OMyx8d0oQTynIQT/wKwzuO1kH4r81zbJpPEGEo/fQv+mh9lLMxxfVxGDilw2lIrrASa/b+uPdI8RVT7mrM6LCUVrJ81OvaXz2YFsiACMNlYb6k+2wc6wmQwL/DbSJzibf92QEiQCRpMVhWaOpap9pKDKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvSnDEtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596F7C4CED2;
	Wed,  9 Oct 2024 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728484979;
	bh=6JEg1IWQ9xC5kwBpzTwz9Zj3qaAc3eJWc5MRgFK88fQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TvSnDEtvtsN6C+/SM0y/Zbf/0mXF2Mn40y3by2HXHrux1RDGnG93kLUpMEWmcPDrK
	 sOX+zsHqBO9edGNccIA/BCVzwphzpD+8sT1rkGL39LV+4W0hIPChLuzaCgFDX0tdGy
	 99IVRBVIcPd2UUNFhIHbCdepzcA5TkxeWzO6/DBQLQGBKFDV2dchgAC/8u9eZEmdSM
	 DUkmjUJm0gsBfLV8mqdVdGhYdlmkqSqM/x64gpO4AglxBO94SHpBjV2cfuXtgmN/GB
	 A53oHen1qpgDxEIXmusKyzpNQeVORIpc9p/FWuCMW3NmDpM1hhfUcVeNWO26s7z7sk
	 fBvhb+rJfGSzA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e98821b12eso427161eaf.0;
        Wed, 09 Oct 2024 07:42:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCDTaGPaRiKophEcChLd4fLRjBBqYiz1Tgi44WIbKTRmJw3GyXkutfnid2C9l2hIBp1a8ft8tHTqDS@vger.kernel.org, AJvYcCUxAd/FsL1Baa5zi69nVRrsWhmAocXfS+GfD46OJTmrk2ow09eR2wb+wjgt+U6QHs9tTK9O0cEuWRF6Gos=@vger.kernel.org, AJvYcCVPwbgIH3/MO21WeVLpeALCwCL7EYSYorkstwA1CjzlktPXEUG3UAFMedmOr7nX5zcsToTs6swQVoIPjdCI@vger.kernel.org, AJvYcCWCBxJOV52K+oVrq6NhQJ+bNp9TSuBKQ4aLqJ//suq0ceErs/F+wAYTb5t8TMgHlaEbDFxZ1EC0vI+Q@vger.kernel.org, AJvYcCX0ESV3g5fNOKZPpE9zLFnNPd08qCnta6O9EUkAG/AcHeLZTOV9tNZNzmdBKsGYDjtFIB1/6RbQgJ5z@vger.kernel.org
X-Gm-Message-State: AOJu0YxtltHQf5mg59GAWtTmEDOcal8Nuu2t4fWgjUQdg6193T0LEJC8
	jZxoJhLHQ0vnjueDSvgRCln1MH6gXNObN1hztSv7pcedZiur6craOCYuXCOx1Qb9X2zt/pGynFi
	LTT2g0FQjZ3RFp/NrBqrAbmuUkmU=
X-Google-Smtp-Source: AGHT+IHDaVFF9QB5Ocw0e+agFVyqw6KDF/qmyIN+xkqeGE34qYEEyNH3bqQh/xYpVKP/VbDhTkTKtGu9dtJoOOgnpNU=
X-Received: by 2002:a05:6820:80b:b0:5e1:e65d:5148 with SMTP id
 006d021491bc7-5e987ba3164mr1641923eaf.6.1728484978584; Wed, 09 Oct 2024
 07:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com> <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 16:42:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFco4htzfW1sYYKKh67oe4GsnUBOPRiunHQ1n2FHa3hA@mail.gmail.com>
Message-ID: <CAJZ5v0iFco4htzfW1sYYKKh67oe4GsnUBOPRiunHQ1n2FHa3hA@mail.gmail.com>
Subject: Re: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:17=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wrot=
e:
>
> Additional DCD region (partition) information is contained in the DSMAS
> CDAT tables, including performance, read only, and shareable attributes.
>
> Match DCD partitions with DSMAS tables and store the meta data.
>
> To: Robert Moore <robert.moore@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> To: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linux.dev
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes:
> [iweiny: new patch]
> [iweiny: Gather shareable/read-only flags for later use]
> ---
>  drivers/cxl/core/cdat.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c |  2 ++
>  drivers/cxl/cxlmem.h    |  3 +++
>  include/acpi/actbl1.h   |  2 ++
>  4 files changed, 45 insertions(+)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bd50bb655741..9b2f717a16e5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -17,6 +17,8 @@ struct dsmas_entry {
>         struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>         int entries;
>         int qos_class;
> +       bool shareable;
> +       bool read_only;
>  };
>
>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> @@ -74,6 +76,8 @@ static int cdat_dsmas_handler(union acpi_subtable_heade=
rs *header, void *arg,
>                 return -ENOMEM;
>
>         dent->handle =3D dsmas->dsmad_handle;
> +       dent->shareable =3D dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> +       dent->read_only =3D dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
>         dent->dpa_range.start =3D le64_to_cpu((__force __le64)dsmas->dpa_=
base_address);
>         dent->dpa_range.end =3D le64_to_cpu((__force __le64)dsmas->dpa_ba=
se_address) +
>                               le64_to_cpu((__force __le64)dsmas->dpa_leng=
th) - 1;
> @@ -255,6 +259,38 @@ static void update_perf_entry(struct device *dev, st=
ruct dsmas_entry *dent,
>                 dent->coord[ACCESS_COORDINATE_CPU].write_latency);
>  }
>
> +
> +static void update_dcd_perf(struct cxl_dev_state *cxlds,
> +                           struct dsmas_entry *dent)
> +{
> +       struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> +       struct device *dev =3D cxlds->dev;
> +
> +       for (int i =3D 0; i < mds->nr_dc_region; i++) {
> +               /* CXL defines a u32 handle while cdat defines u8, ignore=
 upper bits */
> +               u8 dc_handle =3D mds->dc_region[i].dsmad_handle & 0xff;
> +
> +               if (resource_size(&cxlds->dc_res[i])) {
> +                       struct range dc_range =3D {
> +                               .start =3D cxlds->dc_res[i].start,
> +                               .end =3D cxlds->dc_res[i].end,
> +                       };
> +
> +                       if (range_contains(&dent->dpa_range, &dc_range)) =
{
> +                               if (dent->handle !=3D dc_handle)
> +                                       dev_warn(dev, "DC Region/DSMAS mi=
s-matched handle/range; region %pra (%u); dsmas %pra (%u)\n"
> +                                                     "   setting DC regi=
on attributes regardless\n",
> +                                               &dent->dpa_range, dent->h=
andle,
> +                                               &dc_range, dc_handle);
> +
> +                               mds->dc_region[i].shareable =3D dent->sha=
reable;
> +                               mds->dc_region[i].read_only =3D dent->rea=
d_only;
> +                               update_perf_entry(dev, dent, &mds->dc_per=
f[i]);
> +                       }
> +               }
> +       }
> +}
> +
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>                                      struct xarray *dsmas_xa)
>  {
> @@ -278,6 +314,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_s=
tate *cxlds,
>                 else if (resource_size(&cxlds->pmem_res) &&
>                          range_contains(&pmem_range, &dent->dpa_range))
>                         update_perf_entry(dev, dent, &mds->pmem_perf);
> +               else if (cxl_dcd_supported(mds))
> +                       update_dcd_perf(cxlds, dent);
>                 else
>                         dev_dbg(dev, "no partition for dsmas dpa: %pra\n"=
,
>                                 &dent->dpa_range);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b51ddd1ff94..3ba465823564 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1649,6 +1649,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(st=
ruct device *dev)
>         mds->cxlds.type =3D CXL_DEVTYPE_CLASSMEM;
>         mds->ram_perf.qos_class =3D CXL_QOS_CLASS_INVALID;
>         mds->pmem_perf.qos_class =3D CXL_QOS_CLASS_INVALID;
> +       for (int i =3D 0; i < CXL_MAX_DC_REGION; i++)
> +               mds->dc_perf[i].qos_class =3D CXL_QOS_CLASS_INVALID;
>
>         return mds;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0690b917b1e0..c3b889a586d8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -466,6 +466,8 @@ struct cxl_dc_region_info {
>         u64 blk_size;
>         u32 dsmad_handle;
>         u8 flags;
> +       bool shareable;
> +       bool read_only;
>         u8 name[CXL_DC_REGION_STRLEN];
>  };
>
> @@ -533,6 +535,7 @@ struct cxl_memdev_state {
>
>         u8 nr_dc_region;
>         struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +       struct cxl_dpa_perf dc_perf[CXL_MAX_DC_REGION];
>
>         struct cxl_event_state event;
>         struct cxl_poison_state poison;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 199afc2cd122..387fc821703a 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
>  /* Flags for subtable above */
>
>  #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
> +#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
> +#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
>
>  /* Subtable 1: Device scoped Latency and Bandwidth Information Structure=
 (DSLBIS) */
>

Is there an upstream ACPICA commit for this?

